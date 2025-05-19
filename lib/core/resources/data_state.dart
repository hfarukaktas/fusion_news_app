import 'dart:io';

abstract class DataState<T> {
  final T? data;
  final HttpException? exception;

  const DataState({this.data, this.exception});
}

class DataSuccess<T> extends DataState<T> {
  const DataSuccess(T data) : super(data: data);
}

class DataFailed<T> extends DataState<T> {
  const DataFailed(HttpException exception) : super(exception: exception);
}
