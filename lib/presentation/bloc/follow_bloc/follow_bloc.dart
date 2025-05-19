// follow_bloc.dart
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'follow_event.dart';
import 'follow_state.dart';

class FollowBloc extends Bloc<FollowEvent, FollowState> {
  FollowBloc() : super(FollowInitial()) {
    on<LoadFollowStatus>(_onLoadStatus);
    on<ToggleFollowStatus>(_onToggleFollow);
  }

  Future<void> _onLoadStatus(
    LoadFollowStatus event,
    Emitter<FollowState> emit,
  ) async {
    emit(FollowLoading());
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      emit(FollowError('Kullanıcı giriş yapmamış.'));
      return;
    }

    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);
    final snapshot = await userDoc.get();
    final sources = snapshot.data()?['news_sources'] ?? [];

    emit(FollowLoaded(sources.contains(event.sourceId)));
  }

  Future<void> _onToggleFollow(
    ToggleFollowStatus event,
    Emitter<FollowState> emit,
  ) async {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      emit(FollowError('Kullanıcı giriş yapmamış.'));
      return;
    }

    final userDoc = FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid);

    await FirebaseFirestore.instance.runTransaction((transaction) async {
      final snapshot = await transaction.get(userDoc);
      List<dynamic> sources = snapshot.data()?['news_sources'] ?? [];

      bool isFollowing = sources.contains(event.sourceId);
      if (isFollowing) {
        sources.remove(event.sourceId);
      } else {
        sources.add(event.sourceId);
      }
      transaction.update(userDoc, {'news_sources': sources});
      emit(FollowLoaded(!isFollowing));
    });
  }
}
