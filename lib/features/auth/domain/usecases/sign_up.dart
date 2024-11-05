import 'package:equatable/equatable.dart';
import 'package:job_landing_course/core/usecase/usecase.dart';
import 'package:job_landing_course/core/utils/typedef.dart';
import 'package:job_landing_course/features/auth/domain/repositories/auth_repo.dart';

class SignUp extends UsecaseWithParams<void, SignUpParams> {
  SignUp({required AuthRepo repo}) : _repo = repo;
  final AuthRepo _repo;

  @override
  ResultFuture<void> call(SignUpParams params) => _repo.signUp(
        email: params.email,
        fullName: params.fullName,
        password: params.password,
      );
}

class SignUpParams extends Equatable {
  const SignUpParams({
    required this.email,
    required this.fullName,
    required this.password,
  });

  final String email;
  final String fullName;
  final String password;

  const SignUpParams.empty()
      : this(
          email: '',
          fullName: '',
          password: '',
        );

  @override
  List<Object?> get props => [email, fullName, password];
}
