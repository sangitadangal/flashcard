import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/leetcode_question.dart';
import '../services/flashcard_provider.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Progress Tracking'),
        actions: [
          Consumer<FlashcardProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: const Icon(Icons.refresh),
                tooltip: 'Reset Progress',
                onPressed: () {
                  _showResetDialog(context, provider);
                },
              );
            },
          ),
        ],
      ),
      body: Consumer<FlashcardProvider>(
        builder: (context, provider, child) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Overall progress card
                _buildOverallProgressCard(provider),
                const SizedBox(height: 24),

                // Difficulty breakdown
                _buildSectionHeader('Progress by Difficulty'),
                const SizedBox(height: 12),
                _buildDifficultyProgress(provider),
                const SizedBox(height: 24),

                // Category breakdown
                _buildSectionHeader('Progress by Category'),
                const SizedBox(height: 12),
                _buildCategoryProgress(provider),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildOverallProgressCard(FlashcardProvider provider) {
    final progress = provider.progress;
    final masteredCount = provider.masteredCount;
    final totalCount = provider.totalCount;
    final percentage = (progress * 100).toStringAsFixed(0);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.blue[400]!, Colors.blue[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.blue.withValues(alpha: 0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          const Text(
            'Overall Progress',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 150,
                height: 150,
                child: CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 12,
                  backgroundColor: Colors.white.withValues(alpha: 0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
              Column(
                children: [
                  Text(
                    '$percentage%',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '$masteredCount / $totalCount',
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Text(
            'Questions Mastered',
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDifficultyProgress(FlashcardProvider provider) {
    final difficultyProgress = provider.getDifficultyProgress();

    return Column(
      children: [
        _buildProgressBar(
          'Easy',
          Colors.green,
          difficultyProgress[Difficulty.easy]!['mastered']!,
          difficultyProgress[Difficulty.easy]!['total']!,
        ),
        const SizedBox(height: 12),
        _buildProgressBar(
          'Medium',
          Colors.orange,
          difficultyProgress[Difficulty.medium]!['mastered']!,
          difficultyProgress[Difficulty.medium]!['total']!,
        ),
        const SizedBox(height: 12),
        _buildProgressBar(
          'Hard',
          Colors.red,
          difficultyProgress[Difficulty.hard]!['mastered']!,
          difficultyProgress[Difficulty.hard]!['total']!,
        ),
      ],
    );
  }

  Widget _buildCategoryProgress(FlashcardProvider provider) {
    final categoryProgress = provider.getCategoryProgress();
    final sortedCategories = categoryProgress.keys.toList()..sort();

    return Column(
      children: sortedCategories.map((category) {
        final mastered = categoryProgress[category]!['mastered']!;
        final total = categoryProgress[category]!['total']!;
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: _buildProgressBar(
            category,
            Colors.blue,
            mastered,
            total,
          ),
        );
      }).toList(),
    );
  }

  Widget _buildProgressBar(String label, Color color, int mastered, int total) {
    final progress = total > 0 ? mastered / total : 0.0;
    final percentage = (progress * 100).toStringAsFixed(0);

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  label,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Text(
                '$mastered / $total',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey[600],
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Stack(
            children: [
              Container(
                height: 8,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
              FractionallySizedBox(
                widthFactor: progress,
                child: Container(
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            '$percentage% complete',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  void _showResetDialog(BuildContext context, FlashcardProvider provider) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Reset Progress'),
          content: const Text(
            'Are you sure you want to reset all progress? This will mark all questions as not mastered.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                provider.resetProgress();
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Progress has been reset'),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
              ),
              child: const Text('Reset'),
            ),
          ],
        );
      },
    );
  }
}
