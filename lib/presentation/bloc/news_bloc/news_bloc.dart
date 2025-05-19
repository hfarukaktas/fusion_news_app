import 'package:flutter_bloc/flutter_bloc.dart';
import 'news_event.dart';
import 'news_state.dart';
import '../../../domain/usecases/get_news_list.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final GetNewsList getNewsListUseCase;

  NewsBloc(this.getNewsListUseCase) : super(NewsInitial()) {
    on<FetchNews>((event, emit) async {
      emit(NewsLoading());
      try {
        final data = await getNewsListUseCase(event.rssUrl);
        emit(NewsLoaded(data));
      } catch (e) {
        emit(NewsError(e.toString()));
      }
    });
  }
}
