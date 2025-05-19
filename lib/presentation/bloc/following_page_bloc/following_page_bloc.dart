import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/data/datasource/news_remote_datasource.dart';
import 'package:fusion_news_app/data/datasource/firestore_service.dart';
import 'package:fusion_news_app/presentation/bloc/following_page_bloc/following_page_event.dart';
import 'package:fusion_news_app/presentation/bloc/following_page_bloc/following_page_state.dart';

class FollowedNewsBloc extends Bloc<FollowedNewsEvent, FollowedNewsState> {
  final FirestoreService _firestoreService;
  final NewsRemoteDatasource _newsDatasource;
  final String userId;

  FollowedNewsBloc({
    required this.userId,
    required FirestoreService firestoreService,
    required NewsRemoteDatasource newsDatasource,
  }) : _firestoreService = firestoreService,
       _newsDatasource = newsDatasource,
       super(FollowedNewsLoading()) {
    on<FetchFollowedNews>(_onFetchFollowedNews);
  }

  Future<void> _onFetchFollowedNews(
    FetchFollowedNews event,
    Emitter<FollowedNewsState> emit,
  ) async {
    try {
      final sourceIds = await _firestoreService.getFollowedSourceIds(userId);

      final rssLinks = await _firestoreService.getRssLinksFromSources(
        sourceIds,
      );

      final newsFutures = rssLinks.map(_newsDatasource.getNewsList).toList();
      final newsLists = await Future.wait(newsFutures);

      final allNews = newsLists.expand((list) => list).toList();
      allNews.sort((a, b) => b.newsPubDate.compareTo(a.newsPubDate));

      emit(FollowedNewsLoaded(allNews));
    } catch (e) {
      emit(FollowedNewsError(e.toString()));
    }
  }
}
