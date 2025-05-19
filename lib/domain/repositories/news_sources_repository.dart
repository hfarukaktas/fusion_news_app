import 'package:fusion_news_app/domain/entities/news_source_item.dart';

abstract class NewsSourcesRepository {
  Future<List<NewsSourceItem>> getNewsSources();
}
