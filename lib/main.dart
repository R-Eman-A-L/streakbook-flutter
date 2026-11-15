import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streak_book/data/fake_quote_repository.dart';
import 'package:streak_book/data/saved_habit_repository.dart';
import 'package:streak_book/di/providers.dart';
import 'package:streak_book/ui/habit_detail/habit_detail_screen.dart';
import 'package:streak_book/ui/habit_list/habit_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notebook = SharedPreferencesAsync();
  final habitsText = await notebook.getString('habits');
  final savedNextId = await notebook.getInt('nextId');

  final repository = SavedHabitRepository(notebook, habitsText, savedNextId);

  runApp(
    ProviderScope(
      overrides: [habitRepositoryProvider.overrideWith((ref) => repository)],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'StreakBook',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: Builder(
        builder: (context) {
          return HabitListScreen(
            onOpenHabit: (id) => Navigator.of(context).push(
              MaterialPageRoute(builder: (_) => HabitDetailScreen(habitId: id)),
            ),
          );
        },
      ),
    );
  }
}
