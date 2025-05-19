import 'package:fusion_news_app/data/models/news_model.dart';

abstract class FollowedNewsState {}

class FollowedNewsLoading extends FollowedNewsState {}

class FollowedNewsLoaded extends FollowedNewsState {
  final List<NewsModel> news;
  FollowedNewsLoaded(this.news);
}

class FollowedNewsError extends FollowedNewsState {
  final String message;
  FollowedNewsError(this.message);
}
