import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:streak_book/data/quote_repository.dart';
import 'package:streak_book/models/quote.dart';

// ===== 4. STEPS: NetworkQuoteRepository.getQuote() =====
// Goal: gives back a Quote, or throws.
// Have: the HTTP client, the URL https://dummyjson.com/quotes/random
//   1. send a GET request to the URL                     ← throws by itself if no reply
//   2. if the status isn't 2xx → throw "Bad status: <the number>"   ← STOP
//   3. read the body → a QuoteForm (JSON tool)           ← throws by itself if unreadable
//   4. form.toQuote()
//   5. give back the Quote
// Throw by themselves, no step from me: no reply (no internet, timeout), unreadable body.

class NetworkQuoteRepository implements QuoteRepository {
  final http.Client _client;

  const NetworkQuoteRepository(this._client);

  @override
  Future<Quote> getQuote() async {
    final Uri url = Uri.parse('https://dummyjson.com/quotes/random');

    final response = await _client
        .get(url)
        .timeout(const Duration(seconds: 10));

    if (response.statusCode < 200 && response.statusCode >= 300) {
      throw Exception('Bad status: ${response.statusCode}');
    }

    final form = jsonDecode(response.body) as Map<String, dynamic>;
    return QuoteForm.fromJson(form).toQuote();
  }
}
