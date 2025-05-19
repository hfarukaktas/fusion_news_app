import 'package:fusion_news_app/data/models/news_model.dart';

abstract class TrendingNewsState {}

class TrendingNewsLoading extends TrendingNewsState {}

class TrendingNewsLoaded extends TrendingNewsState {
  final List<NewsModel> news;
  TrendingNewsLoaded(this.news);
}

class TrendingNewsError extends TrendingNewsState {
  final String message;
  TrendingNewsError(this.message);
}
