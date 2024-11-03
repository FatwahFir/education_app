import 'package:equatable/equatable.dart';
import 'package:job_landing_course/core/usecase/usecase.dart';
import 'package:job_landing_course/core/utils/typedef.dart';
import 'package:job_landing_course/features/auth/domain/entities/local_user.dart';
import 'package:job_landing_course/features/auth/domain/repositories/auth_repo.dart';

class SignIn extends UsecaseWithParams<LocalUser, SignInParams> {
  SignIn({required AuthRepo repo}) : _repo = repo;
  final AuthRepo _repo;

  @override
  ResultFuture<LocalUser> call(SignInParams params) => _repo.signIn(
        email: params.email,
        password: params.password,
      );
}

class SignInParams extends Equatable {
  const SignInParams({required this.email, required this.password});

  final String email;
  final String password;

  const SignInParams.empty()
      : this(
          email: '',
          password: '',
        );

  @override
  List<Object?> get props => [email, password];
}
