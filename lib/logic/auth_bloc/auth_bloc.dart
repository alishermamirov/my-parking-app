// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import 'package:my_parking_app/models/user_model.dart';
import 'package:my_parking_app/services/user_service.dart';

import '../../services/auth_service.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;
  final UserService userService;

  AuthBloc({required this.authService, required this.userService})
    : super(AuthInitial()) {
    on<AppStarted>(_onAppStarted);
    on<SignInEvent>(_onSignIn);
    on<SignUpEvent>(_onSignUp);
    on<SignOutEvent>(_onSignOut);
  }

  void _onAppStarted(AppStarted event, Emitter<AuthState> emit) {
    final user = authService.currentUser;
    if (user != null) {
      emit(AuthAuthenticated(user.uid));
    } else {
      emit(AuthUnauthenticated());
    }
  }

  Future<void> _onSignIn(SignInEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = await authService.signIn(
      email: event.email,
      password: event.password,
    );
    if (user != null) {
      emit(AuthAuthenticated(user.uid));
    } else {
      emit(const AuthError("Login failed"));
    }
  }

  Future<void> _onSignUp(SignUpEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    final user = await authService.signUp(
      email: event.email,
      password: event.password,
    );

    if (user != null) {
      final userData = UserModel(
        userId: user.uid,
        userName: event.userName,
        email: event.email,
      );
      await userService.saveUserData(userData);
      emit(AuthAuthenticated(user.uid));
    } else {
      emit(const AuthError("SignUp failed"));
    }
  }

  Future<void> _onSignOut(SignOutEvent event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    await authService.signOut();
    emit(AuthUnauthenticated());
  }
}
