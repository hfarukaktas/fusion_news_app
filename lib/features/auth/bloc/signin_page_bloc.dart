import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/features/auth/bloc/auth_event.dart';
import 'package:fusion_news_app/features/auth/bloc/auth_state.dart';
import 'package:fusion_news_app/features/auth/services/auth_service.dart';

class SigninPageBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authRepository;
  SigninPageBloc({required this.authRepository}) : super(Unauthenticated()) {
    on<SignInRequested>(_onSignInRequested);
  }

  Future<void> _onSignInRequested(
    SignInRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    try {
      final userCredential = await authRepository.signIn(
        email: event.email,
        password: event.password,
      );
      emit(Authenticated(userCredential.user!.uid));
      print('giris yapildi');
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }
}
