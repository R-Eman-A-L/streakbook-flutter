import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:streak_book/data/network_quote_repository.dart';

void main() {
  group('NetworkQuoteRepository', () {
    test('A 500 reply makes getQuote() throw', () async {
      final client = MockClient(
        (request) async => http.Response(
          '{"id": 1, "quote": "Stay hungry", "author": "Steve Jobs"}',
          500,
        ),
      );

      final repository = NetworkQuoteRepository(client);

      await expectLater(
        repository.getQuote(),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Bad status: 500'),
          ),
        ),
      );
    });

    test('(R) A 201 rply with a valid quote is accepted', () async {
      final client = MockClient(
        (request) async => http.Response(
          '{"id": 1, "quote": "Stay hungry", "author": "Steve Jobs"}',
          201,
        ),
      );

      final repository = NetworkQuoteRepository(client);
      final quote = await repository.getQuote();

      expect(quote.text, "Stay hungry");
      expect(quote.author, "Steve Jobs");
    });
  });
}
