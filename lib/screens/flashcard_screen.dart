import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/flashcard_set.dart';
import '../services/flashcard_provider.dart';
import '../widgets/flashcard_widget.dart';
import 'filter_screen.dart';
import 'progress_screen.dart';

class FlashcardScreen extends StatelessWidget {
  final FlashcardSet flashcardSet;

  const FlashcardScreen({super.key, required this.flashcardSet});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FlashcardProvider.withQuestions(flashcardSet.questions),
      child: _FlashcardScreenContent(flashcardSet: flashcardSet),
    );
  }
}

class _FlashcardScreenContent extends StatelessWidget {
  final FlashcardSet flashcardSet;

  const _FlashcardScreenContent({required this.flashcardSet});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(flashcardSet.title),
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
                          builder: (_) => ChangeNotifierProvider.value(
                            value: provider,
                            child: const FilterScreen(),
                          ),
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
          Consumer<FlashcardProvider>(
            builder: (context, provider, child) {
              return IconButton(
                icon: const Icon(Icons.bar_chart),
                tooltip: 'Progress',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ChangeNotifierProvider.value(
                        value: provider,
                        child: const ProgressScreen(),
                      ),
                    ),
                  );
                },
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
                    const SizedBox(height: 12),
                    // Hide Mastered Toggle
                    GestureDetector(
                      onTap: () {
                        provider.toggleHideMastered();
                      },
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: provider.hideMastered ? Colors.blue : Colors.grey[200],
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: provider.hideMastered ? Colors.blue : Colors.grey[400]!,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              provider.hideMastered ? Icons.visibility_off : Icons.visibility,
                              size: 16,
                              color: provider.hideMastered ? Colors.white : Colors.grey[700],
                            ),
                            const SizedBox(width: 6),
                            Text(
                              provider.hideMastered ? 'Mastered Hidden' : 'Show All',
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w600,
                                color: provider.hideMastered ? Colors.white : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(width: 4),
                            if (provider.hideMastered)
                              Text(
                                '(${provider.filteredCount})',
                                style: const TextStyle(
                                  fontSize: 11,
                                  color: Colors.white70,
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),

          // Flashcard
          Expanded(
            child: Consumer<FlashcardProvider>(
              builder: (context, provider, child) {
                // Show empty state if no questions available
                if (provider.filteredCount == 0) {
                  return Container(
                    color: Colors.grey[50],
                    padding: const EdgeInsets.all(32),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.celebration,
                            size: 80,
                            color: Colors.amber,
                          ),
                          const SizedBox(height: 24),
                          Text(
                            'All Questions Mastered!',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.grey[800],
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Great job! You\'ve mastered all questions in this set.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.grey[600],
                            ),
                          ),
                          const SizedBox(height: 24),
                          ElevatedButton.icon(
                            onPressed: () {
                              provider.toggleHideMastered();
                            },
                            icon: const Icon(Icons.visibility),
                            label: const Text('Show Mastered Cards'),
                            style: ElevatedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }

                return Container(
                  color: Colors.grey[50],
                  padding: const EdgeInsets.all(16),
                  child: const Center(
                    child: FlashcardWidget(),
                  ),
                );
              },
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
