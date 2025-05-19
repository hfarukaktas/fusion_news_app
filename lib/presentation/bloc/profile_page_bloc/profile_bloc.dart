// profile_bloc.dart
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  ProfileBloc() : super(ProfileInitial()) {
    on<LoadProfile>((event, emit) async {
      emit(ProfileLoading());
      try {
        final user = _auth.currentUser;
        if (user == null) {
          emit(ProfileUnauthenticated());
          return;
        }

        final userDoc =
            await _firestore.collection('users').doc(user.uid).get();

        if (!userDoc.exists) {
          emit(ProfileError(message: 'Kullanıcı bulunamadı'));
          return;
        }

        final userData = userDoc.data()!;
        final userName = userData['name']?.toString() ?? 'İsimsiz Kullanıcı';
        final userEmail = userData['email']?.toString() ?? 'Bilinmeyen Email';
        final newsSources = List<String>.from(userData['news_sources'] ?? []);

        emit(
          ProfileLoaded(
            userName: userName,
            userEmail: userEmail,
            newsSources: newsSources,
          ),
        );
      } catch (e) {
        emit(ProfileError(message: 'Veri yüklenemedi: ${e.toString()}'));
      }
    });

    on<RemoveNewsSource>((event, emit) async {
      try {
        final user = _auth.currentUser;
        if (user == null) {
          emit(ProfileUnauthenticated());
          return;
        }

        if (state is ProfileLoaded) {
          final currentState = state as ProfileLoaded;
          final updatedSources = List<String>.from(currentState.newsSources)
            ..remove(event.sourceId);

          await _firestore.collection('users').doc(user.uid).update({
            'news_sources': updatedSources,
          });

          emit(
            ProfileLoaded(
              userName: currentState.userName,
              userEmail: currentState.userEmail,
              newsSources: updatedSources,
            ),
          );
        }
      } catch (e) {
        emit(
          ProfileError(
            message: 'Takipten çıkma işlemi başarısız: ${e.toString()}',
          ),
        );
      }
    });
  }
}
