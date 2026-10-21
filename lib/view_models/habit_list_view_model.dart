import 'package:flutter/foundation.dart';
import 'package:streak_book/data/habit_repository.dart';
import 'package:streak_book/models/habit_list_ui_state.dart';

class HabitListViewModel extends ChangeNotifier {
  HabitListViewModel(this._repository) {
    _refresh();
  }

  final HabitRepository _repository;

  HabitListUiState _state = const HabitListUiState();
  HabitListUiState get state => _state;

  void _refresh([String? error]) {
    final habits = _repository.getHabits();
    final doneCount = habits.where((h) => h.doneToday).length;
    _state = HabitListUiState(
      habits: habits,
      doneCount: doneCount,
      error: error,
    );
    notifyListeners();
  }

  void onToggle(int id) {
    _repository.toggle(id);
    _refresh();
  }

  void onDelete(int id) {
    _repository.delete(id);
    _refresh();
  }

  bool onAdd(String name) {
    final problem = _validate(name);
    if (problem != null) {
      _refresh(problem);
      return false;
    }

    _repository.add(name);
    _refresh();
    return true;
  }

  void onTextChanged() {
    if (_state.error == null) return;

    _refresh();
  }

  String? _validate(String value) {
    final habits = _repository.getHabits();
    final name = value.trim();

    if (name.isEmpty) return "Enter a habit name";
    if (habits.any((h) => h.name == name)) {
      return 'You already have that habit';
    }

    return null;
  }
}
