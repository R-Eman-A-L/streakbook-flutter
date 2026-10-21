import 'package:flutter/material.dart';
import 'package:streak_book/data/in_memory_habit_repository.dart';
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
  final _viewModel = HabitListViewModel(InMemoryHabitRepository());
  final _controller = TextEditingController();

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
          final state = _viewModel.state;
          final habits = state.habits;
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        labelText: 'New habit',
                        errorText: state.error,
                      ),
                      onChanged: (_) => _viewModel.onTextChanged(),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Add habit',
                    onPressed: () {
                      if (_viewModel.onAdd(_controller.text)) {
                        _controller.clear();
                      }
                    },
                    icon: const Icon(Icons.add),
                  ),
                ],
              ),
              Text('${state.doneCount} of ${habits.length} done today'),
              Expanded(
                child: habits.isEmpty
                    ? const Center(child: Text('No habits yet'))
                    : ListView.builder(
                        itemCount: habits.length,
                        itemBuilder: (context, index) {
                          final habit = habits[index];
                          return ListTile(
                            title: Text(habit.name),
                            onTap: () => _viewModel.onToggle(habit.id),

                            onLongPress: () => _viewModel.onDelete(habit.id),
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
