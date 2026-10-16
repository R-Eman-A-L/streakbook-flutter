import 'package:flutter/material.dart';

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

class HabitListScreen extends StatefulWidget {
  const HabitListScreen({super.key});

  @override
  State<HabitListScreen> createState() => _HabitListScreenState();
}

class _HabitListScreenState extends State<HabitListScreen> {
  final Set<String> done = {};

  @override
  Widget build(BuildContext context) {
    List<String> habits = ['Read', 'Gym', 'Water', 'Walk'];

    return Scaffold(
      appBar: AppBar(title: const Text('StreakBook')),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) {
          final habit = habits[index];
          return ListTile(
            title: Text(habit),
            onTap: () {
              setState(() {
                if (done.contains(habit)) {
                  done.remove(habit);
                } else {
                  done.add(habit);
                }
              });
            },
            trailing: done.contains(habit)
                ? const Icon(Icons.check)
                : null,
          );
        },
      ),
    );
  }
}
