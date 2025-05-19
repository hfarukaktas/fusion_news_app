import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/domain/entities/news_source_item.dart';
import 'package:fusion_news_app/domain/usecases/get_news_sources_usecase.dart';
import 'package:fusion_news_app/presentation/bloc/search_bloc/search_events.dart';
import 'package:fusion_news_app/presentation/bloc/search_bloc/search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final GetNewsSourcesUsecase getNewsSourcesListUseCase;
  List<NewsSourceItem> _allSources = [];

  SearchBloc({required this.getNewsSourcesListUseCase})
    : super(NewsSourcesInitial()) {
    on<FetchNewsSources>((event, emit) async {
      emit(NewsSourceshLoading());
      try {
        _allSources = await getNewsSourcesListUseCase();
        emit(NewsSourcesLoaded(_allSources));
      } catch (e) {
        emit(SearchError(e.toString()));
      }
    });

    on<FilterNewsSources>((event, emit) {
      final filteredList =
          _allSources.where((source) {
            final query = event.query.toLowerCase();
            final sourceName = source.source_name.toLowerCase();
            return sourceName.contains(query);
          }).toList();

      emit(NewsSourcesLoaded(filteredList));
    });
  }
}
