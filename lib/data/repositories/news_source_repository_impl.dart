import 'package:fusion_news_app/data/datasource/news_source_remote_datasource.dart';
import 'package:fusion_news_app/domain/entities/news_source_item.dart';
import 'package:fusion_news_app/domain/repositories/news_sources_repository.dart';

class NewsSourceRepositoryImpl implements NewsSourcesRepository {
  final NewsSourceRemoteDatasource datasource;
  NewsSourceRepositoryImpl(this.datasource);

  @override
  Future<List<NewsSourceItem>> getNewsSources() => datasource.getNewsSources();
}
