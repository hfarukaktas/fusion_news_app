import 'package:flutter/material.dart';
import 'package:fusion_news_app/domain/entities/news_item.dart';

class NewsDetailPage extends StatelessWidget {
  final NewsItem news;

  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(news.newsSource), centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              news.newsImage,
              width: double.infinity,
              height: 220,
              fit: BoxFit.cover,
              errorBuilder:
                  (_, __, ___) => const Icon(Icons.broken_image, size: 100),
            ),

            const SizedBox(height: 16),

            // Başlık
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                news.newsTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 12),

            // Kaynak
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Kaynak: ${news.newsSource}',
                style: const TextStyle(
                  fontSize: 14,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                news.newsContent,
                style: const TextStyle(fontSize: 16, height: 1.5),
              ),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
