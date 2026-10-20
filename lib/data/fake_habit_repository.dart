import 'package:streak_book/data/habit_repository.dart';
import 'package:streak_book/models/habit.dart';

class FakeHabitRepository implements HabitRepository {
  final List<Habit> _habits = [
    const Habit(id: 1, name: 'Test A'),
    const Habit(id: 2, name: 'Test B'),

  ];

  int _nextId = 3;

  @override
  void add(String name) {
    _habits.add(Habit(id: _nextId++, name: name.trim()));
  }

  @override
  void delete(int id) {
    _habits.removeWhere((h) => h.id == id);
  }

  @override
  List<Habit> getHabits() => List.unmodifiable(_habits);

  @override
  void toggle(int id) {
    final i = _habits.indexWhere((h) => h.id == id);
    if (i == -1) return;
    final current = _habits[i];
    _habits[i] = current.copyWith(doneToday: !current.doneToday);
  }
}
