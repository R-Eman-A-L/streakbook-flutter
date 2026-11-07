// ===== 3. PLAN: SavedHabitRepository =====
// What InMemoryHabitRepository keeps (its fields): the habit list, nextId
// So the notebook must hold: the habit list AND nextId
//
// When the app starts (the repository is created)
// Goal: its fields hold the saved habits and nextId if the notebook had data,
//       or the 4 starting habits and their nextId if it was empty.
//       That way getHabits() can answer.
// Have: the notebook, the fields (the list, nextId), the starting habits
//   1. open the notebook and check whether it has saved data
//   2. if it has data: put the saved habits and nextId into the fields
//   3. if it's empty (first time ever): put the starting habits and their nextId into the fields
//
// After add, toggle or delete
// Goal: the notebook holds the same habits and nextId as the fields,
//       so after closing and reopening, the user sees exactly what they left.
// Have: the fields, the notebook, and the parameters:
//       name (add), id + date (toggle), id (delete)
//   1. change the fields the same way InMemoryHabitRepository does (add / toggle / delete)
//   2. save(): write the habits AND nextId to the notebook
//
// save()   (helper, called at the end of add, toggle and delete — written once, DRY)
// Goal: the notebook holds exactly what the fields hold.
// Have: the fields, the notebook
//   1. write the habit list and nextId to the notebook

// ===== 4. TEST PREDICTIONS (do this → close and reopen → expect) =====
//   - add "Read" → close and reopen → "Read" is still in the list
//   - check Gym and Read → close and reopen → both still checked, and "2 of 5 done today" is still right
//   - add "Read" → close and reopen → add "Walk" → delete "Walk"
//       → expect only Walk gone, Read still there
//       (if nextId wasn't saved, Walk would get Read's id, and deleting Walk would delete Read too)
//   - first time ever (uninstall, then run) → expect the 4 starting habits, none checked

import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streak_book/data/habit_repository.dart';
import 'package:streak_book/models/habit.dart';

class SavedHabitRepository implements HabitRepository {
  final SharedPreferencesAsync _notebook;
  late List<Habit> _habits;
  late int _nextId;
  SavedHabitRepository(this._notebook, String? habitsText, int? savedNextId) {
    if (habitsText == null) {
      _habits = [
        const Habit(id: 1, name: 'Read'),
        Habit(id: 2, name: 'Gym', completedDates: {DateTime(2026, 10, 30)}),
        const Habit(id: 3, name: 'Water'),
        const Habit(id: 4, name: 'Walk'),
      ];
      _nextId = 5;
      return;
    }

    final forms = jsonDecode(habitsText) as List;

    _habits = forms
        .map((form) => Habit.fromJson(form as Map<String, dynamic>))
        .toList();

    int biggestId = 0;
    for (final habit in _habits) {
      if (habit.id > biggestId) biggestId = habit.id;
    }
    _nextId = savedNextId ?? biggestId + 1;
  }

  @override
  List<Habit> getHabits() => List.unmodifiable(_habits);

  @override
  void add(String name) {
    _habits.add(Habit(id: _nextId++, name: name.trim()));
    _save();
  }

  @override
  void delete(int id) {
    _habits.removeWhere((h) => h.id == id);
    _save();
  }

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
    _save();
  }

  @override
  Habit? getHabit(int id) => _habits.firstWhereOrNull((h) => h.id == id);

  void _save() {
    final habitsText = jsonEncode(
      _habits.map((habit) => habit.toJson()).toList(),
    );

    _notebook.setString('habits', habitsText);
    _notebook.setInt('nextId', _nextId);
  }
}
