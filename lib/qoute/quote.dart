class Quote {
  final String quote;
  final String author;
  final String category;

  Quote({required this.quote, required this.author, required this.category});

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      quote: json['quote'], // ✅ Must match API key spelling
      author: json['author'] ?? 'Unknown',
      category: json['category'] ?? 'General',
    );
  }
}
