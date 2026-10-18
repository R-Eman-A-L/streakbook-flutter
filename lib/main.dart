import 'package:flutter/material.dart';
import 'package:streak_book/models/habit.dart';

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
  final List<Habit> habits = [
    const Habit(id: 1, name: 'Read'),
    const Habit(id: 2, name: 'Gym'),
    const Habit(id: 3, name: 'Water'),
    const Habit(id: 4, name: 'Walk'),
  ];
  int _nextId = 5;
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StreakBook')),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'New habit'),
                    validator: (value) {
                      final name = value?.trim() ?? '';
                      if (name.isEmpty) return "Enter a habit name";
                      if (habits.any((h) => h.name == name)) {
                        return 'You already have that habit';
                      }
                      return null;
                    },
                  ),
                ),
                IconButton(
                  tooltip: 'Add habit',
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final name = _controller.text.trim();
                      setState(() {
                        habits.add(Habit(id: _nextId++, name: name));
                        _controller.clear();
                      });
                    }
                  },
                  icon: const Icon(Icons.add),
                ),
              ],
            ),
          ),
          Expanded(
            child: habits.isEmpty
                ? const Center(child: Text('No habits yet'))
                : ListView.builder(
                    itemCount: habits.length,
                    itemBuilder: (context, index) {
                      final habit = habits[index];
                      return ListTile(
                        title: Text(habit.name),
                        onTap: () {
                          final i = habits.indexWhere((h) => h.id == habit.id);
                          setState(() {
                            habits[i] = habit.copyWith(
                              doneToday: !habit.doneToday,
                            );
                          });
                        },
                        onLongPress: () {
                          setState(() {
                            habits.removeWhere((h) => h.id == habit.id);
                          });
                        },
                        trailing: habit.doneToday
                            ? const Icon(Icons.check)
                            : null,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
