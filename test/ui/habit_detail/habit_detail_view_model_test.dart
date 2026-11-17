import 'package:flutter_test/flutter_test.dart';
import 'package:streak_book/data/clock.dart';
import 'package:streak_book/data/fake_habit_repository.dart';
import 'package:streak_book/models/habit.dart';
import 'package:streak_book/ui/habit_detail/habit_detail_view_model.dart';

void main() {
  group('HabitDetailViewModel', () {
    late FakeHabitRepository habitRepository;
    late FakeClock clock;

    setUp(() {
      final habits = [
        Habit(id: 1, name: 'Read'),
        Habit(id: 2, name: 'Gym', completedDates: {DateTime(2026, 10, 30)}),
        Habit(id: 3, name: 'Water'),
        Habit(id: 4, name: 'Walk'),
      ];
      habitRepository = FakeHabitRepository(habits: habits);
      clock = FakeClock(DateTime(2026, 11, 16));
    });

    test('An id that doesn\'t exist shows "not found"', () {
      final viewModel = HabitDetailViewModel(99, habitRepository, clock);

      expect(viewModel.state.isNotFound, isTrue);
    });

    test(
      'A habit done yesterday and the day before, but not today, has 2-day streak',
      () {
        final habits = [
          Habit(
            id: 2,
            name: 'Gym',
            completedDates: {DateTime(2026, 11, 14), DateTime(2026, 11, 15)},
          ),
        ];

        habitRepository = FakeHabitRepository(habits: habits);
        final viewModel = HabitDetailViewModel(2, habitRepository, clock);

        expect(viewModel.state.currentStreak, 2);
        expect(viewModel.state.doneToday, isFalse);
      },
    );
  });
}
