import 'package:equatable/equatable.dart';

abstract class NewsEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchNews extends NewsEvent {
  final String rssUrl;

  FetchNews(this.rssUrl);

  @override
  List<Object?> get props => [rssUrl];
}
