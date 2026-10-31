import 'package:streak_book/models/habit.dart';

abstract class HabitRepository {
  List<Habit> getHabits();
  void add(String name);
  void toggle(int id, DateTime date);
  void delete(int id);
  Habit? getHabit(int id);
}
