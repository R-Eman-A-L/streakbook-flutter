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
  final List<String> habits = ['Read', 'Gym', 'Water', 'Walk'];
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
                      if (habits.contains(name)) {
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
                      setState(() {
                        habits.add(_controller.text.trim());
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
                        onLongPress: () {
                          setState(() {
                            habits.remove(habit);
                            done.remove(habit);
                          });
                        },
                        trailing: done.contains(habit)
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
