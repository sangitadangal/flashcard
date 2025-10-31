import 'dart:math';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/leetcode_question.dart';
import '../services/flashcard_provider.dart';

class FlashcardWidget extends StatefulWidget {
  const FlashcardWidget({super.key});

  @override
  State<FlashcardWidget> createState() => _FlashcardWidgetState();
}

class _FlashcardWidgetState extends State<FlashcardWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _flipCard() {
    final provider = Provider.of<FlashcardProvider>(context, listen: false);
    if (_controller.status == AnimationStatus.completed) {
      _controller.reverse();
    } else {
      _controller.forward();
    }
    provider.flipCard();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashcardProvider>(
      builder: (context, provider, child) {
        final question = provider.currentQuestion;

        if (question == null) {
          return const Center(
            child: Text(
              'No questions available',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
          );
        }

        // Reset animation when showing front side (question changes or isShowingAnswer is false)
        if (!provider.isShowingAnswer && _controller.value > 0) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _controller.reset();
          });
        }

        return GestureDetector(
          onTap: _flipCard,
          onHorizontalDragEnd: (details) {
            if (details.primaryVelocity! > 0) {
              provider.previousQuestion();
            } else if (details.primaryVelocity! < 0) {
              provider.nextQuestion();
            }
          },
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              final angle = _animation.value * pi;
              final isFront = _animation.value < 0.5;

              // Create transform for current side
              final transform = Matrix4.identity()
                ..setEntry(3, 2, 0.001)
                ..rotateY(angle);

              return Transform(
                transform: transform,
                alignment: Alignment.center,
                child: Visibility(
                  visible: isFront,
                  replacement: Transform(
                    transform: Matrix4.rotationY(pi),
                    alignment: Alignment.center,
                    child: _buildBackSide(question),
                  ),
                  child: _buildFrontSide(question),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildFrontSide(LeetCodeQuestion question) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(minHeight: 400),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title
              Text(
                question.title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              // Difficulty badge
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: _getDifficultyColor(question.difficulty),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  question.difficulty.toString().split('.').last.toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              // Category
              Text(
                question.category,
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 24),
              // Question
              Text(
                question.question,
                style: const TextStyle(
                  fontSize: 16,
                  height: 1.6,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBackSide(LeetCodeQuestion question) {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        padding: const EdgeInsets.all(24),
        constraints: const BoxConstraints(minHeight: 400),
        child: SolutionTabView(question: question),
      ),
    );
  }

  Color _getDifficultyColor(Difficulty difficulty) {
    switch (difficulty) {
      case Difficulty.easy:
        return Colors.green;
      case Difficulty.medium:
        return Colors.orange;
      case Difficulty.hard:
        return Colors.red;
    }
  }
}

class SolutionTabView extends StatefulWidget {
  final LeetCodeQuestion question;

  const SolutionTabView({super.key, required this.question});

  @override
  State<SolutionTabView> createState() => _SolutionTabViewState();
}

class _SolutionTabViewState extends State<SolutionTabView> {
  int _selectedTab = 0;
  bool _showCode = false;

  @override
  Widget build(BuildContext context) {
    final solution = _selectedTab == 0 ? widget.question.bruteForce : widget.question.optimized;

    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Tab buttons
          Row(
            children: [
              Expanded(
                child: _buildTabButton(
                  'Brute Force',
                  0,
                  Colors.orange,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildTabButton(
                  'Optimized',
                  1,
                  Colors.green,
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),

          // Complexity info
          _buildComplexityInfo(solution),
          const SizedBox(height: 20),

          // Explanation (moved to top)
          const Text(
            'Explanation:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            solution.explanation,
            style: const TextStyle(fontSize: 14, height: 1.6),
          ),
          const SizedBox(height: 20),

          // View Code button
          ElevatedButton.icon(
            onPressed: () {
              setState(() {
                _showCode = !_showCode;
              });
            },
            icon: Icon(_showCode ? Icons.keyboard_arrow_up : Icons.visibility),
            label: Text(_showCode ? 'Hide Code' : 'View Code'),
            style: ElevatedButton.styleFrom(
              backgroundColor: _selectedTab == 0 ? Colors.orange : Colors.green,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            ),
          ),

          // Code section (collapsible)
          if (_showCode) ...[
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(8),
              ),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  solution.code,
                  style: const TextStyle(
                    fontFamily: 'monospace',
                    fontSize: 14,
                    color: Colors.greenAccent,
                  ),
                ),
              ),
            ),
          ],
          const SizedBox(height: 20),

          // Steps (moved to bottom)
          const Text(
            'Approach:',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          ...solution.steps.asMap().entries.map((entry) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: _selectedTab == 0 ? Colors.orange : Colors.green,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '${entry.key + 1}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      entry.value,
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ),
                ],
              ),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildTabButton(String label, int index, Color color) {
    final isSelected = _selectedTab == index;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedTab = index;
          _showCode = false;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          color: isSelected ? color : Colors.grey[200],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              color: isSelected ? Colors.white : Colors.grey[700],
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildComplexityInfo(Solution solution) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Time',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  solution.timeComplexity,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 1,
            height: 30,
            color: Colors.grey[300],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Space',
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    solution.spaceComplexity,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
