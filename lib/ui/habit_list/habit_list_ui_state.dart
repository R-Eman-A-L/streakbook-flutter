import 'package:streak_book/models/habit.dart';
import 'package:streak_book/models/quote_state.dart';

class HabitListUiState {
  final List<Habit> habits;
  final int doneCount;
  final Set<int> doneTodayIds;
  final String? error;
  final QuoteState quote;

  const HabitListUiState({
    this.habits = const [],
    this.doneCount = 0,
    this.doneTodayIds = const {},
    this.error,
    this.quote = const QuoteLoading(),
  });

  HabitListUiState copyWith({
    List<Habit>? habits,
    int? doneCount,
    Set<int>? doneTodayIds,
    String? error,
    QuoteState? quote,
  }) {
    return HabitListUiState(
      habits: habits ?? this.habits,
      doneCount: doneCount ?? this.doneCount,
      doneTodayIds: doneTodayIds ?? this.doneTodayIds,
      error: error ?? this.error,
      quote: quote ?? this.quote,
    );
  }
}
