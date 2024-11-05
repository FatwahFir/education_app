import 'package:dartz/dartz.dart';
import 'package:job_landing_course/core/enums/user_action_enum.dart';
import 'package:job_landing_course/core/errors/exceptions.dart';
import 'package:job_landing_course/core/errors/failure.dart';
import 'package:job_landing_course/core/utils/typedef.dart';
import 'package:job_landing_course/features/auth/data/datasources/auth_remote_data_src.dart';
import 'package:job_landing_course/features/auth/domain/entities/local_user.dart';
import 'package:job_landing_course/features/auth/domain/repositories/auth_repo.dart';

class AuthRepoImpl extends AuthRepo {
  AuthRepoImpl({required AuthRemoteDataSrc remoteDataSrc})
      : _remoteDataSrc = remoteDataSrc;
  final AuthRemoteDataSrc _remoteDataSrc;

  @override
  ResultVoid forgotPassword(String email) async {
    try {
      await _remoteDataSrc.forgotPassword(email);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultFuture<LocalUser> signIn(
      {required String email, required String password}) async {
    try {
      final res = await _remoteDataSrc.signIn(email: email, password: password);
      return Right(res);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultVoid signUp(
      {required String email,
      required String fullName,
      required String password}) async {
    try {
      await _remoteDataSrc.signUp(
          email: email, fullName: fullName, password: password);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }

  @override
  ResultVoid updateUser(
      {required UserActionEnum action, required userData}) async {
    try {
      await _remoteDataSrc.updateUser(action: action, userData: userData);
      return const Right(null);
    } on ServerException catch (e) {
      return Left(
        ServerFailure(
          message: e.message,
          statusCode: e.statusCode,
        ),
      );
    }
  }
}
