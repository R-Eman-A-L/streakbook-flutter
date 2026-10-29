import 'package:flutter/material.dart';
import 'package:streak_book/data/habit_repository.dart';
import 'package:streak_book/data/in_memory_habit_repository.dart';
import 'package:streak_book/ui/habit_detail/habit_detail_screen.dart';
import 'package:streak_book/ui/habit_list/habit_list_screen.dart';

void main() {
  final repository = InMemoryHabitRepository();
  runApp(MyApp(repository: repository));
}

class MyApp extends StatelessWidget {
  final HabitRepository repository;
  const MyApp({super.key, required this.repository});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreakBook',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: Builder(
        builder: (context) {
          return HabitListScreen(
            repository: repository,
            onOpenHabit: (id) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) =>
                    HabitDetailScreen(habitId: id, repository: repository),
              ),
            ),
          );
        },
      ),
    );
  }
}
