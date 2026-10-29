import 'package:flutter/material.dart';
import 'package:streak_book/data/habit_repository.dart';
import 'package:streak_book/ui/habit_detail/habit_detail_view_model.dart';

class HabitDetailScreen extends StatefulWidget {
  final int habitId;
  final HabitRepository repository;
  const HabitDetailScreen({
    super.key,
    required this.habitId,
    required this.repository,
  });

  @override
  State<HabitDetailScreen> createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends State<HabitDetailScreen> {
  late final HabitDetailViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = HabitDetailViewModel(widget.habitId, widget.repository);
  }

  @override
  void dispose() {
    _viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Habit")),
      body: ListenableBuilder(
        listenable: _viewModel,
        builder: (context, _) {
          final state = _viewModel.state;
          return (state.isNotFound)
              ? Center(child: Text("Habit not found"))
              : Center(
                  child: Column(
                    mainAxisSize: .min,
                    children: [
                      Text('${state.habitName}'),
                      Text(
                        'The status of the habit is: ${(state.doneToday) ? "Done today ✓" : "Not done yet"}',
                      ),
                    ],
                  ),
                );
        },
      ),
    );
  }
}
