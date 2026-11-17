import 'package:streak_book/data/quote_repository.dart';
import 'package:streak_book/models/quote.dart';

class FakeQuoteRepository implements QuoteRepository {
  final bool shouldFail;
  final Duration delay;

  const FakeQuoteRepository({
    this.shouldFail = false,
    this.delay = Duration.zero,
  });

  @override
  Future<Quote> getQuote() async {
    await Future.delayed(delay);

    if (shouldFail) throw Exception('Fake failure');

    return Quote(
      text:
          'The truth was a mirror in the hands of God. It fell, and broke into pieces. Everybody took a piece of it, and they looked at it and thought they had the truth.',
      author: 'Rumi',
    );
  }
}
