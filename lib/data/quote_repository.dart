import 'package:streak_book/models/quote.dart';

abstract class QuoteRepository {
  Future<Quote> getQuote();
}
