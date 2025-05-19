// follow_event.dart
abstract class FollowEvent {}

class LoadFollowStatus extends FollowEvent {
  final String sourceId;
  LoadFollowStatus(this.sourceId);
}

class ToggleFollowStatus extends FollowEvent {
  final String sourceId;
  ToggleFollowStatus(this.sourceId);
}
