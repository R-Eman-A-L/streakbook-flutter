import 'package:flutter/material.dart';
import 'package:streak_book/models/quote_state.dart';

class QuoteCard extends StatelessWidget {
  final QuoteState quote;
  final VoidCallback onRetry;

  const QuoteCard({super.key, required this.quote, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final text = Theme.of(context).textTheme;

    return Card(
      elevation: 0,
      color: colors.surfaceContainerHighest,
      margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: AnimatedSize(                       // smooth height change between situations
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(children: [
                Icon(Icons.format_quote, size: 18, color: colors.primary),
                const SizedBox(width: 6),
                Text('Quote of the day',
                    style: text.labelMedium?.copyWith(color: colors.primary)),
              ]),
              const SizedBox(height: 10),
              switch (quote) {
                QuoteLoading() => Row(children: [
                    const SizedBox(
                      width: 16, height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    ),
                    const SizedBox(width: 10),
                    Text('Loading quote…', style: text.bodyMedium),
                  ]),
                QuoteError(:final message) => Row(children: [
                    Icon(Icons.error_outline, size: 20, color: colors.error),
                    const SizedBox(width: 8),
                    Expanded(child: Text(message, style: text.bodyMedium)),
                    TextButton.icon(
                      onPressed: onRetry,
                      icon: const Icon(Icons.refresh, size: 18),
                      label: const Text('Try again'),
                    ),
                  ]),
                QuoteSuccess(:final quote) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('“${quote.text}”',
                          style: text.bodyLarge?.copyWith(fontStyle: FontStyle.italic, height: 1.4)),
                      const SizedBox(height: 8),
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text('— ${quote.author}',
                            style: text.bodyMedium?.copyWith(color: colors.onSurfaceVariant)),
                      ),
                    ],
                  ),
              },
            ],
          ),
        ),
      ),
    );
  }
}