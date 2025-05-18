import 'package:flutter/material.dart';
import 'quote.dart'; // ✅ Use correct spelling if renamed
import 'Services.dart';

class QuoteScreen extends StatefulWidget {
  const QuoteScreen({super.key});

  @override
  State<QuoteScreen> createState() => _QuoteScreenState();
}

class _QuoteScreenState extends State<QuoteScreen> {
  late Future<List<Quote>> future;

  @override
  void initState() {
    super.initState();
    future = fetchQuote();
  }

  Future<void> _refresh() async {
    setState(() {
      future = fetchQuote();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quotes'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _refresh,
          ),
        ],
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/tir.jpg"), // ✅ Optional background
            fit: BoxFit.cover,
          ),
        ),
        child: FutureBuilder<List<Quote>>(
          future: future,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(
                child: Text("Error: ${snapshot.error}"),
              );
            }

            if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return const Center(child: Text("No quotes found."));
            }

            return RefreshIndicator(
              onRefresh: _refresh, // ✅ Pull to refresh
              child: ListView.builder(
                padding: const EdgeInsets.all(12),
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final quote = snapshot.data![index];

                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '"${quote.quote}"',
                            style: const TextStyle(
                              fontSize: 18,
                              fontStyle: FontStyle.italic,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "- ${quote.author}",
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Text(
                            quote.category,
                            style: const TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            );
          },
        ),
      ),
    );
  }
}
