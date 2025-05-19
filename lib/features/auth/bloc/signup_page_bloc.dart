import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fusion_news_app/features/auth/bloc/auth_event.dart';
import 'package:fusion_news_app/features/auth/bloc/auth_state.dart';
import 'package:fusion_news_app/features/auth/services/auth_service.dart';
import 'package:fusion_news_app/features/auth/services/user_service.dart';

class SignupPageBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authRepository;
  final UserService userService;

  SignupPageBloc({required this.authRepository, required this.userService})
    : super(Unauthenticated()) {
    on<SignUpRequested>(_onSignUpRequested);
  }

  Future<void> _onSignUpRequested(
    SignUpRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(Loading());
    try {
      final userCredential = await authRepository.signUp(
        email: event.email,
        password: event.password,
      );

      await userService.createUser(
        email: event.email,
        name: event.name,
        id: userCredential.user!.uid,
      );
      emit(Authenticated(userCredential.user!.uid));
    } catch (e) {
      emit(AuthError(e.toString()));
      emit(Unauthenticated());
    }
  }
}
