import 'package:equatable/equatable.dart';
import '../../../domain/entities/news_item.dart';

abstract class NewsState extends Equatable {
  @override
  List<Object?> get props => [];
}

class NewsInitial extends NewsState {}

class NewsLoading extends NewsState {}

class NewsLoaded extends NewsState {
  final List<NewsItem> newsList;

  NewsLoaded(this.newsList);

  @override
  List<Object?> get props => [newsList];
}

class NewsError extends NewsState {
  final String message;

  NewsError(this.message);

  @override
  List<Object?> get props => [message];
}
