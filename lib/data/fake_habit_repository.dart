import 'package:streak_book/data/habit_repository.dart';
import 'package:streak_book/models/habit.dart';
import 'package:collection/collection.dart';

class FakeHabitRepository implements HabitRepository {
  final List<Habit> _habits;
  int _nextId = 1;

  FakeHabitRepository({List<Habit>? habits})
    : _habits = List.of(habits ?? _startingHabits()) {
    // the constructor BODY runs after _habits is filled, so it can look at the list
    int biggestId = 0;
    for (final habit in _habits) {
      if (habit.id > biggestId) biggestId = habit.id;
    }
    _nextId = biggestId + 1;
  }

  static List<Habit> _startingHabits() => [
    const Habit(id: 1, name: 'Read'),
    Habit(id: 2, name: 'Gym', completedDates: {DateTime(2026, 10, 30)}),
    const Habit(id: 3, name: 'Water'),
    const Habit(id: 4, name: 'Walk'),
  ];

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
  void toggle(int id, DateTime date) {
    final i = _habits.indexWhere((h) => h.id == id);
    if (i == -1) return;
    final current = _habits[i];
    final completedDates = Set.of(current.completedDates);

    if (completedDates.contains(date)) {
      completedDates.remove(date);
    } else {
      completedDates.add(date);
    }
    _habits[i] = current.copyWith(completedDates: completedDates);
  }

  @override
  Habit? getHabit(int id) {
    return _habits.firstWhereOrNull((h) => h.id == id);
  }
}
