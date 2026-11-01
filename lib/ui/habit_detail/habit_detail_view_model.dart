import 'package:flutter/foundation.dart';
import 'package:streak_book/data/clock.dart';
import 'package:streak_book/data/habit_repository.dart';
import 'package:streak_book/ui/habit_detail/habit_detail_ui_state.dart';

class HabitDetailViewModel extends ChangeNotifier {
  final int _habitId;
  final HabitRepository _repository;
  final Clock _clock;

  HabitDetailUiState _state = const HabitDetailUiState();
  HabitDetailUiState get state => _state;

  HabitDetailViewModel(this._habitId, this._repository, this._clock) {
    _load();
  }

  void _load() {
    final habit = _repository.getHabit(_habitId);

    if (habit == null) {
      _state = HabitDetailUiState(isNotFound: true);
      notifyListeners();
      return;
    }
    final today = _clock.today();
    final completedDates = habit.completedDates;

    final doneToday = completedDates.contains(today);
    final last7Days = _last7Days(completedDates, today);
    final currentStreak = _currentStreak(completedDates, today);

    _state = HabitDetailUiState(
      habitName: habit.name,
      doneToday: doneToday,
      isNotFound: false,
      last7Days: last7Days,
      currentStreak: currentStreak,
    );

    notifyListeners();
  }

  List<bool> _last7Days(final Set<DateTime> dates, DateTime today) {
    final days = <bool>[];
    DateTime day = DateTime(today.year, today.month, today.day - 6);

    for (var i = 0; i < 7; i++) {
      days.add(dates.contains(day));
      day = DateTime(day.year, day.month, day.day + 1);
    }

    return days;
  }

  int _currentStreak(final Set<DateTime> dates, DateTime today) {
    int streak = 0;
    DateTime day = (dates.contains(today))
        ? today
        : DateTime(today.year, today.month, today.day - 1);

    while (dates.contains(day)) {
      streak++;
      day = DateTime(day.year, day.month, day.day - 1);
    }

    return streak;
  }
}
