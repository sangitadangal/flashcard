import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/flashcard_provider.dart';
import '../widgets/flashcard_widget.dart';
import 'filter_screen.dart';
import 'progress_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NeetCode 150'),
        actions: [
          // Filter button
          Consumer<FlashcardProvider>(
            builder: (context, provider, child) {
              return Stack(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.filter_list,
                      color: provider.isFiltered ? Colors.blue : Colors.white,
                    ),
                    tooltip: 'Filter',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FilterScreen(),
                        ),
                      );
                    },
                  ),
                  if (provider.isFiltered)
                    Positioned(
                      right: 8,
                      top: 8,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          color: Colors.red,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
          // Progress button
          IconButton(
            icon: const Icon(Icons.bar_chart),
            tooltip: 'Progress',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const ProgressScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Progress bar
          Consumer<FlashcardProvider>(
            builder: (context, provider, child) {
              return Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 5,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Progress: ${provider.masteredCount} / ${provider.totalCount}',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${(provider.progress * 100).toStringAsFixed(0)}%',
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: LinearProgressIndicator(
                        value: provider.progress,
                        minHeight: 8,
                        backgroundColor: Colors.grey[200],
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Flashcard
          Expanded(
            child: Container(
              color: Colors.grey[50],
              padding: const EdgeInsets.all(16),
              child: const Center(
                child: FlashcardWidget(),
              ),
            ),
          ),

          // Bottom controls
          Consumer<FlashcardProvider>(
            builder: (context, provider, child) {
              return Container(
                padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 5,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Question counter
                    Column(
                      children: [
                        if (provider.currentQuestion != null)
                          Text(
                            'Question ${provider.currentIndex + 1} of ${provider.filteredCount}',
                            style: const TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          ),
                        if (provider.isFiltered)
                          Text(
                            'Filtered from ${provider.totalCount} total',
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.blue,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 20),

                    // Navigation buttons
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        // Previous button
                        IconButton(
                          icon: const Icon(Icons.chevron_left_rounded),
                          iconSize: 44,
                          color: Colors.blue,
                          onPressed: provider.previousQuestion,
                        ),

                        // Mastered toggle
                        Column(
                          children: [
                            IconButton(
                              icon: Icon(
                                provider.currentQuestion?.isMastered ?? false
                                    ? Icons.star
                                    : Icons.star_outline,
                              ),
                              iconSize: 36,
                              color: provider.currentQuestion?.isMastered ?? false
                                  ? Colors.amber
                                  : Colors.grey,
                              onPressed: provider.toggleMastered,
                            ),
                            Text(
                              provider.currentQuestion?.isMastered ?? false
                                  ? 'Mastered'
                                  : 'Not Mastered',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),

                        // Next button
                        IconButton(
                          icon: const Icon(Icons.chevron_right_rounded),
                          iconSize: 44,
                          color: Colors.blue,
                          onPressed: provider.nextQuestion,
                        ),
                      ],
                    ),

                    const SizedBox(height: 10),

                    // Instructions
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.touch_app, size: 16, color: Colors.grey[600]),
                        const SizedBox(width: 6),
                        Text(
                          'Tap card to flip • Swipe to navigate',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
