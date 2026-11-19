import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:streak_book/data/clock.dart';
import 'package:streak_book/data/fake_habit_repository.dart';
import 'package:streak_book/data/fake_quote_repository.dart';
import 'package:streak_book/di/providers.dart';
import 'package:streak_book/main.dart';

void main() {
  Future<void> pumpApp(WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          habitRepositoryProvider.overrideWith((ref) => FakeHabitRepository()),
          clockProvider.overrideWith(
            (ref) => FakeClock(DateTime(2026, 11, 16)),
          ),
          quoteRepositoryProvider.overrideWith((ref) => FakeQuoteRepository()),
        ],
        child: const MyApp(),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets("Tapping a habit opens its detail screen", (tester) async {
    await pumpApp(tester);
    
    await tester.tap(find.text('Read'));
    await tester.pumpAndSettle();

    expect(
      find.text('The status of the habit is: Not done yet'),
      findsOneWidget,
    );
  });

testWidgets('Checking a habit updates the done count', (tester) async {
  await pumpApp(tester);
  expect(find.text('0 of 4 done today'), findsOneWidget);     // the starting point

  await tester.tap(find.byType(Checkbox).first);
  await tester.pumpAndSettle();

  expect(find.text('1 of 4 done today'), findsOneWidget);     // the change happened
  expect(find.text('0 of 4 done today'), findsNothing);       // and the old text is gone
});

  testWidgets('Long-pressing a habit removes it from the screen', (
    tester,
  ) async {
    await pumpApp(tester);

    await tester.longPress(find.text('Read'));
    await tester.pumpAndSettle();

    expect(find.text('Read'), findsNothing);
  });
}
