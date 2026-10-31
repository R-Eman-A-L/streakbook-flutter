import 'package:flutter/material.dart';
import 'package:streak_book/data/clock.dart';
import 'package:streak_book/data/habit_repository.dart';
import 'package:streak_book/data/in_memory_habit_repository.dart';
import 'package:streak_book/ui/habit_detail/habit_detail_screen.dart';
import 'package:streak_book/ui/habit_list/habit_list_screen.dart';

void main() {
  final repository = InMemoryHabitRepository();
  final clock = SystemClock();
  runApp(MyApp(repository: repository, clock: clock,));
}

class MyApp extends StatelessWidget {
  final HabitRepository repository;
  final Clock clock;
  const MyApp({super.key, required this.repository, required this.clock});

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
            clock: clock,
            onOpenHabit: (id) => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => HabitDetailScreen(
                  habitId: id,
                  repository: repository,
                  clock: clock,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
