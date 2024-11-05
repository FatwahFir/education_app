import 'package:job_landing_course/core/enums/user_action_enum.dart';
import 'package:job_landing_course/core/utils/typedef.dart';
import 'package:job_landing_course/features/auth/domain/entities/local_user.dart';

abstract class AuthRepo {
  ResultVoid forgotPassword(String email);

  ResultFuture<LocalUser> signIn({
    required String email,
    required String password,
  });

  ResultVoid signUp({
    required String email,
    required String fullName,
    required String password,
  });

  ResultVoid updateUser({
    required UserActionEnum action,
    required dynamic userData,
  });
}
