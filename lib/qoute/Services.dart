import 'dart:convert';
import 'package:myapp/qoute/quote.dart';
import "package:http/http.dart" as http;

Future<List<Quote>> fetchQuote() async {
  final response = await http.get(
    Uri.parse('https://api.api-ninjas.com/v1/quotes'),
    headers: {
      'X-Api-Key':
          'mZauDfEFfgaqWLtJtkhuLg==O5laZ3uCVxX6MPoV', // ✅ Secure this in prod
    },
  );

  if (response.statusCode == 200) {
    List<dynamic> data = jsonDecode(response.body);
    return data.map((json) => Quote.fromJson(json)).toList();
  } else {
    throw Exception("Failed to load data: ${response.statusCode}");
  }
}
