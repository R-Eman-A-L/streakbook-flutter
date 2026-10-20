import 'package:flutter/foundation.dart';
import 'package:streak_book/data/habit_repository.dart';
import 'package:streak_book/models/habit.dart';

class HabitListViewModel extends ChangeNotifier {
  HabitListViewModel(this._repository);
  final HabitRepository _repository;

  List<Habit> get habits => _repository.getHabits();

  void toggle(int id) {
    _repository.toggle(id);
    notifyListeners();
  }

  void deleteHabit(int id) {
    _repository.delete(id);
    notifyListeners();
  }

  void addHabit(String name) {
    if (validate(name) != null) return;
    _repository.add(name);
    notifyListeners();
  }

  String? validate(String value) {
    final habits = _repository.getHabits();
    final name = value.trim();

    if (name.isEmpty) return "Enter a habit name";
    if (habits.any((h) => h.name == name)) {
      return 'You already have that habit';
    }

    return null;
  }
}
