import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/data/datasource/news_remote_datasource.dart';
import 'package:fusion_news_app/data/datasource/firestore_service.dart';
import 'package:fusion_news_app/presentation/bloc/trending_news_page_bloc/trending_news_event.dart';
import 'package:fusion_news_app/presentation/bloc/trending_news_page_bloc/trending_news_state.dart';

class TrendingNewsBloc extends Bloc<TrendingNewsEvent, TrendingNewsState> {
  final FirestoreService _firestoreService;
  final NewsRemoteDatasource _newsDatasource;
  final String userId;

  TrendingNewsBloc({
    required this.userId,
    required FirestoreService firestoreService,
    required NewsRemoteDatasource newsDatasource,
  }) : _firestoreService = firestoreService,
       _newsDatasource = newsDatasource,
       super(TrendingNewsLoading()) {
    on<FetchTrendingNews>(_onFetchTrendingNews);
  }

  Future<void> _onFetchTrendingNews(
    FetchTrendingNews event,
    Emitter<TrendingNewsState> emit,
  ) async {
    try {
      // 1. Trending haber kaynağı ID'lerini al
      final sourceIds = await _firestoreService.getTrendingSourceIds(userId);

      // 2. RSS linklerini çek
      final rssLinks = await _firestoreService.getRssLinksFromSources(
        sourceIds,
      );

      // 3. Tüm RSS'lerden haberleri paralel olarak al
      final newsFutures = rssLinks.map(_newsDatasource.getNewsList).toList();
      final newsLists = await Future.wait(newsFutures);

      // 4. Haberleri birleştir ve tarihe göre sırala
      final allNews = newsLists.expand((list) => list).toList();
      allNews.sort((a, b) => b.newsPubDate.compareTo(a.newsPubDate));

      emit(TrendingNewsLoaded(allNews));
    } catch (e) {
      emit(TrendingNewsError(e.toString()));
    }
  }
}
