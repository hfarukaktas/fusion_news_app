import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:fusion_news_app/domain/entities/news_item.dart';
import 'package:fusion_news_app/presentation/pages/news_detail_page.dart';

class NewsGridWidget extends StatelessWidget {
  final List<NewsItem> newsItems;
  final bool isSliver;

  const NewsGridWidget({
    required this.newsItems,
    this.isSliver = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (isSliver) {
      return SliverMasonryGrid(
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        gridDelegate: const SliverSimpleGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
        ),
        delegate: SliverChildBuilderDelegate(
          (context, index) => _NewsGridItem(news: newsItems[index]),
          childCount: newsItems.length, // Doğru yerde
        ),
      );
    }

    return MasonryGridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      padding: EdgeInsets.zero,
      itemCount: newsItems.length,
      itemBuilder: (context, index) => _NewsGridItem(news: newsItems[index]),
    );
  }
}

class _NewsGridItem extends StatelessWidget {
  final NewsItem news;

  const _NewsGridItem({required this.news});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _navigateToDetail(context),
      child: Card(
        child: Column(
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(8),
                topRight: Radius.circular(8),
              ),
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Image.network(
                  news.newsImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorBuilder: (_, __, ___) => const Icon(Icons.broken_image),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0, left: 8.0, right: 8),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  news.newsSource,
                  style: const TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 12,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                news.newsTitle,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NewsDetailPage(news: news)),
    );
  }
}
