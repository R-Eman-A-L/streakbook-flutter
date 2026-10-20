import 'package:flutter/material.dart';
import 'package:streak_book/models/habit.dart';
import 'package:streak_book/view_models/habit_list_view_model.dart';

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
  final _viewModel = HabitListViewModel();
  final _controller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('StreakBook')),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          final habits = _viewModel.habits;
          return Column(
            children: [
              Form(
                key: _formKey,
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _controller,
                        decoration: const InputDecoration(
                          labelText: 'New habit',
                        ),
                        validator: (value) => _viewModel.validate(value ?? ''),
                      ),
                    ),
                    IconButton(
                      tooltip: 'Add habit',
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _viewModel.addHabit(_controller.text);
                          _controller.clear();
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
                              _viewModel.toggle(habit.id);
                            },
                            onLongPress: () => _viewModel.deleteHabit(habit.id),
                            trailing: habit.doneToday
                                ? const Icon(Icons.check)
                                : null,
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }
}
