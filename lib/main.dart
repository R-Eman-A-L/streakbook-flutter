import 'package:flutter/material.dart';
import 'package:streak_book/data/in_memory_habit_repository.dart';
import 'package:streak_book/ui/habit_list/habit_list_screen.dart';
import 'package:streak_book/ui/habit_list/habit_list_view_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreakBook',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: const HabitListScreen(),
    );
  }
}

