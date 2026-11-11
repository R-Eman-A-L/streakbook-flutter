class Quote {
  final String text;
  final String author;

  const Quote({required this.text, required this.author});
}

class QuoteForm {
  final int id;
  final String quote;
  final String author;

  QuoteForm({required this.id, required this.quote, required this.author});

  factory QuoteForm.fromJson(Map<String, dynamic> form) {
    return QuoteForm(
      id: form['id'] as int,
      quote: form['quote'] as String,
      author: form['author'] as String,
    );
  }

  Quote toQuote() {
    return Quote(text: quote, author: author);
  }
}
