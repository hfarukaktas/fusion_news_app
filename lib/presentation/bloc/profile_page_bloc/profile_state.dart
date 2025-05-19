part of 'profile_bloc.dart';

abstract class ProfileState {}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final String userName;
  final String userEmail;
  final List<String> newsSources;

  ProfileLoaded({
    required this.userName,
    required this.userEmail,
    required this.newsSources,
  });
}

class ProfileError extends ProfileState {
  final String message;
  ProfileError({required this.message});
}

class ProfileUnauthenticated extends ProfileState {}
