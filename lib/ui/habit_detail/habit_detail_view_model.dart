import 'package:flutter/widgets.dart';
import 'package:streak_book/data/habit_repository.dart';
import 'package:streak_book/ui/habit_detail/habit_detail_ui_state.dart';

class HabitDetailViewModel extends ChangeNotifier {
  final int _habitId;
  final HabitRepository _repository;

  HabitDetailUiState _state = const HabitDetailUiState();
  HabitDetailUiState get state => _state;

  HabitDetailViewModel(this._habitId, this._repository) {
    _load();
  }

  void _load() {
    final habit = _repository.getHabit(_habitId);
    if (habit == null) {
      _state = HabitDetailUiState(isNotFound: true);
      notifyListeners();
      return;
    }

    _state = HabitDetailUiState(
      habitName: habit.name,
      doneToday: habit.doneToday,
      isNotFound: false,
    );

    notifyListeners();
  }
}
