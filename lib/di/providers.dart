import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:streak_book/data/clock.dart';
import 'package:streak_book/data/habit_repository.dart';
import 'package:streak_book/data/network_quote_repository.dart';
import 'package:streak_book/data/quote_repository.dart';

final habitRepositoryProvider = Provider<HabitRepository>(
  (ref) => throw UnimplementedError(
    'habitRepositoryProvider must be provided in main()',
  ),
);

final clockProvider = Provider<Clock>((ref) => SystemClock());

final httpClientProvider = Provider<http.Client>((ref) => http.Client());

final quoteRepositoryProvider = Provider<QuoteRepository>(
  (ref) => NetworkQuoteRepository(ref.watch(httpClientProvider)),
);
