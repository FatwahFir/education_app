import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_landing_course/core/errors/failure.dart';
import 'package:job_landing_course/features/auth/data/models/local_user_model.dart';
import 'package:job_landing_course/features/auth/domain/usecases/forgot_password.dart';
import 'package:job_landing_course/features/auth/domain/usecases/sign_in.dart';
import 'package:job_landing_course/features/auth/domain/usecases/sign_up.dart';
import 'package:job_landing_course/features/auth/domain/usecases/update_user.dart';
import 'package:job_landing_course/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockSignIn extends Mock implements SignIn {}

class MockSignUp extends Mock implements SignUp {}

class MockForgotPassword extends Mock implements ForgotPassword {}

class MockUpdateUser extends Mock implements UpdateUser {}

void main() {
  late SignIn signIn;
  late SignUp signUp;
  late ForgotPassword forgotPassword;
  late UpdateUser updateUser;
  late AuthBloc authBloc;

  const tSignIn = SignInParams.empty();
  const tSignUp = SignUpParams.empty();
  const tUpdateUser = UpdateUserParams.empty();
  final tServerFailure = ServerFailure(
    message: "Some Errors",
    statusCode: "dummy-errors",
  );

  setUp(() {
    signIn = MockSignIn();
    signUp = MockSignUp();
    forgotPassword = MockForgotPassword();
    updateUser = MockUpdateUser();

    authBloc = AuthBloc(
      signIn: signIn,
      signUp: signUp,
      forgotPassword: forgotPassword,
      updateUser: updateUser,
    );
  });

  setUpAll(
    () {
      registerFallbackValue(tSignIn);
      registerFallbackValue(tSignUp);
      registerFallbackValue(tUpdateUser);
    },
  );

  tearDown(
    () => authBloc.close(),
  );

  test(
    'Initial state must be [AuthInitial]',
    () {
      expect(authBloc.state, const AuthInitial());
    },
  );

  group(
    'SignInEvent',
    () {
      const tUser = LocalUserModel.empty();
      blocTest<AuthBloc, AuthState>(
        'Should emit [AuthLoading, SignedIn] when [SignInEvent] is added.',
        build: () {
          when(() => signIn(any())).thenAnswer(
            (_) async => const Right(tUser),
          );
          return authBloc;
        },
        act: (bloc) {
          bloc.add(
            SignInEvent(email: tSignIn.email, password: tSignIn.password),
          );
        },
        expect: () => [
          const AuthLoading(),
          const SignedIn(userData: tUser),
        ],
        verify: (_) {
          verify(
            () => signIn(tSignIn),
          ).called(1);
          verifyNoMoreInteractions(signIn);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'Should emit [AuthLoading, AuthError] when [SignInEvent] is added.',
        build: () {
          when(() => signIn(any())).thenAnswer(
            (_) async => Left(tServerFailure),
          );
          return authBloc;
        },
        act: (bloc) {
          bloc.add(
            SignInEvent(email: tSignIn.email, password: tSignIn.password),
          );
        },
        expect: () => [
          const AuthLoading(),
          AuthError(message: tServerFailure.message),
        ],
        verify: (_) {
          verify(
            () => signIn(tSignIn),
          ).called(1);
          verifyNoMoreInteractions(signIn);
        },
      );
    },
  );

  group(
    'SignUpEvent',
    () {
      blocTest<AuthBloc, AuthState>(
        'Should emit [AuthLoading, SignedUp] when [SignUpEvent] is added.',
        build: () {
          when(() => signUp(any())).thenAnswer(
            (_) async => const Right(null),
          );
          return authBloc;
        },
        act: (bloc) {
          bloc.add(
            SignUpEvent(
              email: tSignUp.email,
              password: tSignUp.password,
              fullName: tSignUp.fullName,
            ),
          );
        },
        expect: () => [
          const AuthLoading(),
          const SignedUp(),
        ],
        verify: (_) {
          verify(
            () => signUp(tSignUp),
          ).called(1);
          verifyNoMoreInteractions(signUp);
        },
      );

      blocTest<AuthBloc, AuthState>(
        'Should emit [AuthLoading, AuthError] when [SignUpEvent] is added.',
        build: () {
          when(() => signUp(any())).thenAnswer(
            (_) async => Left(tServerFailure),
          );
          return authBloc;
        },
        act: (bloc) {
          bloc.add(
            SignUpEvent(
              email: tSignUp.email,
              password: tSignUp.password,
              fullName: tSignUp.fullName,
            ),
          );
        },
        expect: () => [
          const AuthLoading(),
          AuthError(message: tServerFailure.message),
        ],
        verify: (_) {
          verify(
            () => signUp(tSignUp),
          ).called(1);
          verifyNoMoreInteractions(signUp);
        },
      );
    },
  );
}
