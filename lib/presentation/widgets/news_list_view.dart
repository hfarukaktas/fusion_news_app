import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:fusion_news_app/domain/entities/news_item.dart';
import 'package:fusion_news_app/presentation/pages/news_detail_page.dart';

class TrendingNewsListView extends StatelessWidget {
  final List<NewsItem> trendingNewsItems;
  final bool isSliver;

  const TrendingNewsListView({
    required this.trendingNewsItems,
    this.isSliver = false,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemCount = trendingNewsItems.length;

    Widget buildItem(BuildContext context, int index) {
      final item = trendingNewsItems[index];
      return Padding(
        padding: EdgeInsets.all(8),
        child: GestureDetector(
          onTap:
              () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailPage(news: item),
                ),
              ),
          child: Card(
            elevation: 4,
            margin: const EdgeInsets.symmetric(vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (item.newsImage.isNotEmpty)
                  CachedNetworkImage(
                    imageUrl: item.newsImage,
                    placeholder:
                        (context, url) => Container(
                          width: double.infinity,
                          height: 180,
                          color: Colors.grey[300],
                          child: const Icon(Icons.image_search, size: 40),
                        ),
                    errorWidget:
                        (context, url, error) => const SizedBox(
                          width: double.infinity,
                          height: 180,
                          child: Icon(Icons.broken_image, size: 40),
                        ),
                    imageBuilder:
                        (context, imageProvider) => Container(
                          width: double.infinity,
                          height: 180,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(8),
                            ),
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                  )
                else
                  Container(
                    width: double.infinity,
                    height: 180,
                    decoration: const BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(8),
                      ),
                      color: Colors.grey,
                    ),
                    child: const Icon(Icons.image_not_supported, size: 40),
                  ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                  child: Text(
                    item.newsSource,
                    style: TextStyle(fontSize: 13, color: Colors.grey[600]),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 4, 12, 12),
                  child: Text(
                    item.newsTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    }

    if (isSliver) {
      return SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) => buildItem(context, index),
          childCount: itemCount,
        ),
      );
    } else {
      return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: itemCount,
        itemBuilder: buildItem,
      );
    }
  }
}
