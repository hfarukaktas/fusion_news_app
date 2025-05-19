import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object> get props => [];
}

class Unauthenticated extends AuthState {}

class Loading extends AuthState {}

class Authenticated extends AuthState {
  final String uid;
  Authenticated(this.uid);

  @override
  List<Object> get props => [uid];
}

class AuthError extends AuthState {
  final String error;
  AuthError(this.error);

  @override
  List<Object> get props => [error];
}
