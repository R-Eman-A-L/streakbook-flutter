import 'package:flutter/widgets.dart';
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

    final doneToday = habit.completedDates.contains(_clock.today());
    _state = HabitDetailUiState(
      habitName: habit.name,
      doneToday: doneToday,
      isNotFound: false,
    );

    notifyListeners();
  }
}
