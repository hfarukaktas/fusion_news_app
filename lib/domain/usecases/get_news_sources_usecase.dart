import 'package:fusion_news_app/domain/entities/news_source_item.dart';
import 'package:fusion_news_app/domain/repositories/news_sources_repository.dart';

class GetNewsSourcesUsecase {
  final NewsSourcesRepository repository;
  const GetNewsSourcesUsecase(this.repository);

  Future<List<NewsSourceItem>> call() => repository.getNewsSources();
}
