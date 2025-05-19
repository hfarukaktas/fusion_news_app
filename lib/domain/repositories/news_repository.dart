import '../entities/news_item.dart';

abstract class NewsRepository {
  Future<List<NewsItem>> getNewsList(String rssUrl);
}
