import 'package:streak_book/models/quote.dart';

sealed class QuoteState {
  const QuoteState();
}

class QuoteLoading extends QuoteState {
  const QuoteLoading();
}

class QuoteError extends QuoteState {
  final String message;
  const QuoteError(this.message);
}

class QuoteSuccess extends QuoteState {
  final Quote quote;
  const QuoteSuccess(this.quote);
}
