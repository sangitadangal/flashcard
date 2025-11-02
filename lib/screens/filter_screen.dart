import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/leetcode_question.dart';
import '../services/flashcard_provider.dart';

class FilterScreen extends StatelessWidget {
  const FilterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filter Questions'),
        actions: [
          Consumer<FlashcardProvider>(
            builder: (context, provider, child) {
              return TextButton(
                onPressed: () {
                  provider.clearFilters();
                },
                child: const Text(
                  'Clear All',
                  style: TextStyle(color: Colors.white),
                ),
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
                // Active filters count
                if (provider.isFiltered)
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(12),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).colorScheme.primaryContainer,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(
                        color: Theme.of(context).colorScheme.primary,
                      ),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.filter_alt,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          'Showing ${provider.filteredCount} of ${provider.totalCount} questions',
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.onPrimaryContainer,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                // Difficulty section
                _buildSectionHeader('Difficulty Level'),
                const SizedBox(height: 12),
                _buildDifficultyFilters(provider),
                const SizedBox(height: 32),

                // Category section
                _buildSectionHeader('Categories'),
                const SizedBox(height: 12),
                _buildCategoryFilters(provider),
              ],
            ),
          );
        },
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

  Widget _buildDifficultyFilters(FlashcardProvider provider) {
    return Column(
      children: [
        _buildDifficultyButton(
          provider,
          Difficulty.easy,
          'Easy',
          Colors.green,
          Icons.sentiment_satisfied,
        ),
        const SizedBox(height: 8),
        _buildDifficultyButton(
          provider,
          Difficulty.medium,
          'Medium',
          Colors.orange,
          Icons.sentiment_neutral,
        ),
        const SizedBox(height: 8),
        _buildDifficultyButton(
          provider,
          Difficulty.hard,
          'Hard',
          Colors.red,
          Icons.sentiment_dissatisfied,
        ),
      ],
    );
  }

  Widget _buildDifficultyButton(
    FlashcardProvider provider,
    Difficulty difficulty,
    String label,
    Color color,
    IconData icon,
  ) {
    return Builder(
      builder: (context) {
        final isSelected = provider.selectedDifficulties.contains(difficulty);
        final count = provider.allQuestions
            .where((q) => q.difficulty == difficulty)
            .length;

        return GestureDetector(
          onTap: () {
            provider.toggleDifficulty(difficulty);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? color.withValues(alpha: 0.1)
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected ? color : Theme.of(context).colorScheme.outline,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected ? color : Theme.of(context).colorScheme.surfaceContainerHigh,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isSelected ? Icons.check : icon,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected ? color : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected ? color : Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCategoryFilters(FlashcardProvider provider) {
    final categories = provider.allCategories;

    return Column(
      children: categories.map((category) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: _buildCategoryButton(provider, category),
        );
      }).toList(),
    );
  }

  Widget _buildCategoryButton(FlashcardProvider provider, String category) {
    return Builder(
      builder: (context) {
        final isSelected = provider.selectedCategories.contains(category);
        final count = provider.allQuestions
            .where((q) => q.category == category)
            .length;

        return GestureDetector(
          onTap: () {
            provider.toggleCategory(category);
          },
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: isSelected
                  ? Theme.of(context).colorScheme.primaryContainer
                  : Theme.of(context).colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: isSelected
                    ? Theme.of(context).colorScheme.primary
                    : Theme.of(context).colorScheme.outline,
                width: isSelected ? 2 : 1,
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceContainerHigh,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    isSelected ? Icons.check : Icons.category,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    category,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                      color: isSelected
                          ? Theme.of(context).colorScheme.onPrimaryContainer
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? Theme.of(context).colorScheme.primary
                        : Theme.of(context).colorScheme.surfaceContainerHigh,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '$count',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
