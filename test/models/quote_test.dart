import 'package:flutter_test/flutter_test.dart';
import 'package:streak_book/models/quote.dart';

void main() {
  group('Model Quote', () {
    test('QuoteForm turns the service\'s "quote" label into Quote.text', () {
      final form = {"id": 1, "quote": "Stay hungry", "author": "Steve Jobs"};

      final quote = QuoteForm.fromJson(form).toQuote();

      expect(quote.text, "Stay hungry");
      expect(quote.author, "Steve Jobs");
    });
  });
}
