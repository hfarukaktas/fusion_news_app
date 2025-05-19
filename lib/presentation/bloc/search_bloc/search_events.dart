import 'package:equatable/equatable.dart';

abstract class SearchEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchNewsSources extends SearchEvent {
  FetchNewsSources();

  @override
  List<Object?> get props => [];
}

class FilterNewsSources extends SearchEvent {
  final String query;
  FilterNewsSources({required this.query});
}
