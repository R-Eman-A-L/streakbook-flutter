import 'package:streak_book/models/habit.dart';

class HabitListUiState {
  final List<Habit> habits;
  final int doneCount;
  final String? error;

  const HabitListUiState({
    this.habits = const [],
    this.doneCount = 0,
    this.error,
  });
}
