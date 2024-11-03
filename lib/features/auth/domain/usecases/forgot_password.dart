import 'package:job_landing_course/core/usecase/usecase.dart';
import 'package:job_landing_course/core/utils/typedef.dart';
import 'package:job_landing_course/features/auth/domain/repositories/auth_repo.dart';

class ForgotPassword extends UsecaseWithParams<void, String> {
  ForgotPassword({required AuthRepo repo}) : _repo = repo;

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(String params) => _repo.forgotPassword(params);
}
