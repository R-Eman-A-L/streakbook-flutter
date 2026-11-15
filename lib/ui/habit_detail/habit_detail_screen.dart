import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:streak_book/di/providers.dart';
import 'package:streak_book/ui/habit_detail/habit_detail_view_model.dart';

class HabitDetailScreen extends ConsumerStatefulWidget {
  final int habitId;
  const HabitDetailScreen({super.key, required this.habitId});

  @override
  ConsumerState<HabitDetailScreen> createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends ConsumerState<HabitDetailScreen> {
  late final HabitDetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HabitDetailViewModel(
      widget.habitId,
      ref.read(habitRepositoryProvider),
      ref.read(clockProvider),
    );
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Habit")),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          final state = _viewModel.state;
          return state.isNotFound
              ? Center(child: Text("Habit not found"))
              : Center(
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      Text(state.habitName ?? ''),
                      Text(
                        'The status of the habit is: ${state.doneToday ? "Done today ✓" : "Not done yet"}',
                      ),

                      Row(
                        mainAxisAlignment: .center,
                        children: [
                          for (final done in state.last7Days)
                            Container(
                              width: 24,
                              height: 24,
                              margin: const EdgeInsets.symmetric(horizontal: 4),
                              decoration: BoxDecoration(
                                shape: .circle,
                                color: done
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(
                                        context,
                                      ).colorScheme.surfaceContainerHighest,
                              ),
                            ),
                        ],
                      ),

                      Text(
                        state.currentStreak > 0
                            ? "🔥 ${state.currentStreak}-day streak"
                            : "No streak yet",
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
