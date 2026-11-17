import 'package:flutter_test/flutter_test.dart';
import 'package:streak_book/data/clock.dart';
import 'package:streak_book/data/fake_habit_repository.dart';
import 'package:streak_book/data/fake_quote_repository.dart';
import 'package:streak_book/models/habit.dart';
import 'package:streak_book/models/quote_state.dart';
import 'package:streak_book/ui/habit_list/habit_list_view_model.dart';

void main() {
  group('HabitListViewModel', () {
    late FakeHabitRepository habitRepository;
    late FakeClock clock;
    late FakeQuoteRepository quoteRepository;
    late HabitListViewModel viewModel;

    setUp(() {
      final habits = [
        Habit(id: 1, name: 'Read'),
        Habit(id: 2, name: 'Gym', completedDates: {DateTime(2026, 10, 30)}),
        Habit(id: 3, name: 'Water'),
        Habit(id: 4, name: 'Walk'),
      ];
      habitRepository = FakeHabitRepository(habits: habits);
      clock = FakeClock(DateTime(2026, 11, 16));
      quoteRepository = FakeQuoteRepository();
      viewModel = HabitListViewModel(habitRepository, clock, quoteRepository);
    });

    test(
      'Adding a valid name adds a habit with that name and returns true',
      () {
        final result = viewModel.onAdd('Swim');
        final habits = viewModel.state.habits;

        expect(result, isTrue);
        expect(habits.length, 5);
        expect(habits.any((element) => element.name == "Swim"), isTrue);
      },
    );

    test('Deleting a habit removes exactly that habit', () {
      viewModel.onDelete(1);
      final habits = viewModel.state.habits;

      expect(viewModel.state.habits.length, 3);
      expect(habits.any((element) => element.id == 1), isFalse);
      expect(habits.any((element) => element.name == 'Walk'), isTrue);
      expect(habits.any((element) => element.name == 'Water'), isTrue);
      expect(habits.any((element) => element.name == 'Gym'), isTrue);
    });

    test('A name with only spaces is refused with an error', () {
      final result = viewModel.onAdd("  ");
      final habits = viewModel.state.habits;

      expect(result, isFalse);
      expect(viewModel.state.error, 'Enter a habit name');
      expect(habits.length, 4);
    });

    test('A duplicate name(even with a trailing space) is refused', () {
      final result = viewModel.onAdd('Water ');
      final habits = viewModel.state.habits;

      expect(result, isFalse);
      expect(viewModel.state.error, 'You already have that habit');
      expect(habits.length, 4);
    });

    test('(R) The add error clears when the user types again', () {
      viewModel.onAdd('');
      viewModel.onTextChanged();

      expect(viewModel.state.error, isNull);
    });

    test('Right after building, the quote is Loading', () {
      final viewModel = HabitListViewModel(
        habitRepository,
        clock,
        quoteRepository,
      );

      expect(viewModel.state.quote, isA<QuoteLoading>());
    });

    test('A successful quote load shows the quote', () async {
      // Arrange + Act: a fresh ViewModel (its constructor starts the quote load)
      final viewModel = HabitListViewModel(
        habitRepository,
        clock,
        quoteRepository,
      );

      // wait for the load to finish (the fake has no delay)
      await Future<void>.delayed(const Duration(milliseconds: 10));

      // Assert: 1. check the kind FIRST
      expect(viewModel.state.quote, isA<QuoteSuccess>());

      // 2. only now is it safe to take the quote out
      final quote = (viewModel.state.quote as QuoteSuccess).quote;
      expect(quote.text, startsWith('The truth was a mirror'));
    });

    test(
      'A failed quote load shows the error card, without crashing',
      () async {
        final fakeFaildQuoteRepository = FakeQuoteRepository(shouldFail: true);
        final viewModel = HabitListViewModel(
          habitRepository,
          clock,
          fakeFaildQuoteRepository,
        );
        await Future<void>.delayed(const Duration(milliseconds: 10));

        expect(viewModel.state.quote, isA<QuoteError>());

        expect(
          (viewModel.state.quote as QuoteError).message,
          "Couldn't load the quote",
        );
      },
    );

    test('(R) Checking a habit keeps the quote', () async {
      // Arrange: a fresh ViewModel, then wait for the quote
      final viewModel = HabitListViewModel(
        habitRepository,
        clock,
        quoteRepository,
      );
      await Future<void>.delayed(const Duration(milliseconds: 10));

      // make sure the starting point is right before using it
      expect(viewModel.state.quote, isA<QuoteSuccess>());
      final before = (viewModel.state.quote as QuoteSuccess).quote.text;

      // Act
      viewModel.onToggle(1);

      // Assert: still a Success, with the same text, and the toggle worked
      expect(viewModel.state.quote, isA<QuoteSuccess>());
      expect((viewModel.state.quote as QuoteSuccess).quote.text, before);
      expect(viewModel.state.doneCount, 1);
    });
  });
}
