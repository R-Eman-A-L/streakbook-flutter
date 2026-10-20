import 'package:flutter/foundation.dart';
import 'package:streak_book/models/habit.dart';

class HabitListViewModel extends ChangeNotifier {
  final List<Habit> _habits = [
    const Habit(id: 1, name: 'Read'),
    const Habit(id: 2, name: 'Gym'),
    const Habit(id: 3, name: 'Water'),
    const Habit(id: 4, name: 'Walk'),
  ];

  int _nextId = 5;

  List<Habit> get habits => List.unmodifiable(_habits);

  void toggle(int id) {
    final i = _habits.indexWhere((h) => h.id == id);
    if (i == -1) return;
    final current = _habits[i];
    _habits[i] = current.copyWith(doneToday: !current.doneToday);
    notifyListeners();
  }

  void deleteHabit(int id) {
    _habits.removeWhere((h) => h.id == id);
    notifyListeners();
  }

  void addHabit(String name) {
    if (validate(name) != null) return;
    _habits.add(Habit(id: _nextId++, name: name.trim()));
    notifyListeners();
  }

  String? validate(String value) {
    final name = value.trim();

    if (name.isEmpty) return "Enter a habit name";
    if (_habits.any((h) => h.name == name)) {
      return 'You already have that habit';
    }

    return null;
  }
}
