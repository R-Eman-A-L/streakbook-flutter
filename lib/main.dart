import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:streak_book/data/clock.dart';
import 'package:streak_book/data/habit_repository.dart';
import 'package:streak_book/data/network_quote_repository.dart';
import 'package:streak_book/data/quote_repository.dart';
import 'package:streak_book/data/saved_habit_repository.dart';
import 'package:streak_book/ui/habit_detail/habit_detail_screen.dart';
import 'package:streak_book/ui/habit_list/habit_list_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final notebook = SharedPreferencesAsync();
  final habitsText = await notebook.getString('habits');
  final savedNextId = await notebook.getInt('nextId');

  final repository = SavedHabitRepository(notebook, habitsText, savedNextId);
  final clock = SystemClock();
  final quoteRepository = NetworkQuoteRepository(http.Client());

  runApp(
    MyApp(
      repository: repository,
      clock: clock,
      quoteRepository: quoteRepository,
    ),
  );
}

class MyApp extends StatelessWidget {
  final HabitRepository repository;
  final Clock clock;
  final QuoteRepository quoteRepository;
  const MyApp({
    super.key,
    required this.repository,
    required this.clock,
    required this.quoteRepository,
  });

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
            quoteRepository: quoteRepository,
          );
        },
      ),
    );
  }
}
