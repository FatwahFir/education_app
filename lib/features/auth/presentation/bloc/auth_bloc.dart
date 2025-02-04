import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_landing_course/core/enums/user_action_enum.dart';
import 'package:job_landing_course/features/auth/domain/entities/local_user.dart';
import 'package:job_landing_course/features/auth/domain/usecases/forgot_password.dart';
import 'package:job_landing_course/features/auth/domain/usecases/sign_in.dart';
import 'package:job_landing_course/features/auth/domain/usecases/sign_up.dart';
import 'package:job_landing_course/features/auth/domain/usecases/update_user.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required ForgotPassword forgotPassword,
    required SignIn signIn,
    required SignUp signUp,
    required UpdateUser updateUser,
  })  : _forgorPasswod = forgotPassword,
        _signIn = signIn,
        _signUp = signUp,
        _updateUser = updateUser,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) {
      emit(const AuthLoading());
    });
    on<SignInEvent>(_signInHandler);
    on<SignUpEvent>(_signUpHandler);
  }

  final ForgotPassword _forgorPasswod;
  final SignIn _signIn;
  final SignUp _signUp;
  final UpdateUser _updateUser;

  Future<void> _signInHandler(
      SignInEvent event, Emitter<AuthState> emit) async {
    final result = await _signIn(
      SignInParams(
        email: event.email,
        password: event.password,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (user) => emit(
        SignedIn(userData: user),
      ),
    );
  }

  Future<void> _signUpHandler(
      SignUpEvent event, Emitter<AuthState> emit) async {
    final result = await _signUp(
      SignUpParams(
        email: event.email,
        password: event.password,
        fullName: event.fullName,
      ),
    );

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (_) => emit(
        const SignedUp(),
      ),
    );
  }
}
