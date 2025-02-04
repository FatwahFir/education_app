part of 'auth_bloc.dart';

sealed class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class ForgotPasswordSent extends AuthState {
  const ForgotPasswordSent();
}

class SignedIn extends AuthState {
  const SignedIn({required this.userData});
  final LocalUser userData;

  @override
  List<Object> get props => [userData];
}

class SignedUp extends AuthState {
  const SignedUp();
}

class UserUpdated extends AuthState {
  const UserUpdated();
}

class AuthError extends AuthState {
  const AuthError({required this.message});
  final String message;

  @override
  List<String> get props => [message];
}
