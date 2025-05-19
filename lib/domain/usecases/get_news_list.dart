import 'package:fusion_news_app/domain/repositories/news_repository.dart';

import '../entities/news_item.dart';

class GetNewsList {
  final NewsRepository repository;

  GetNewsList(this.repository);

  Future<List<NewsItem>> call(String rssUrl) {
    return repository.getNewsList(rssUrl);
  }
}
