import 'package:equatable/equatable.dart';
import 'package:fusion_news_app/domain/entities/news_source_item.dart';

abstract class SearchState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsSourcesInitial extends SearchState {}

class NewsSourceshLoading extends SearchState {}

class NewsSourcesLoaded extends SearchState {
  final List<NewsSourceItem> newsSourceList;

  NewsSourcesLoaded(this.newsSourceList);

  @override
  List<Object?> get props => [newsSourceList];
}

class SearchError extends SearchState {
  final String message;

  SearchError(this.message);

  @override
  List<Object?> get props => [message];
}
