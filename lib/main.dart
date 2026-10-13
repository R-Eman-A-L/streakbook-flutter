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
      theme: ThemeData(
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const HabitListScreen(),
    );
  }
}

class HabitListScreen extends StatelessWidget {
  const HabitListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> habits = ['Read', 'Water', 'Gym', 'Walk'];

    return Scaffold(
      appBar: AppBar(title: const Text('StreakBook')),
      body: ListView.builder(
        itemCount: habits.length,
        itemBuilder: (context, index) =>
            ListTile(title: Text(habits[index])),
      ),
    );
  }
}
