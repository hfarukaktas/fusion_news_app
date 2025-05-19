part of 'profile_bloc.dart';

abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class RemoveNewsSource extends ProfileEvent {
  final String sourceId;
  RemoveNewsSource(this.sourceId);
}
