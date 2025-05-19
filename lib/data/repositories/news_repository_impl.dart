import 'package:fusion_news_app/data/datasource/news_remote_datasource.dart';
import 'package:fusion_news_app/domain/entities/news_item.dart';
import 'package:fusion_news_app/domain/repositories/news_repository.dart';

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDatasource remoteDatasource;

  NewsRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<NewsItem>> getNewsList(String rssUrl) async {
    return await remoteDatasource.getNewsList(rssUrl);
  }
}
