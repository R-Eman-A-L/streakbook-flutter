import 'package:streak_book/models/habit.dart';

abstract class HabitRepository {
  List<Habit> getHabits();
  void add(String name);
  void toggle(int id);
  void delete(int id);
}
