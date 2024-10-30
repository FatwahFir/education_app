import 'package:dartz/dartz.dart';
import 'package:job_landing_course/core/errors/exceptions.dart';
import 'package:job_landing_course/core/errors/failure.dart';
import 'package:job_landing_course/core/utils/typedef.dart';
import 'package:job_landing_course/features/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:job_landing_course/features/on_boarding/domain/repositories/on_boarding_repository.dart';

class OnBoardingRepoImpl implements OnBoardingRepository {
  OnBoardingRepoImpl({required OnBoardingLocalDataSource dataSource})
      : _dataSource = dataSource;

  final OnBoardingLocalDataSource _dataSource;

  @override
  ResultVoid cacheFirstTimer() async {
    try {
      await _dataSource.cacheFirstTimer();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(
        CacheFailure(message: e.message, statusCode: e.statusCode),
      );
    }
  }

  @override
  ResultFuture<bool> checkIfUserIsFirstTimer() {
    // TODO: implement checkIfUserIsFirstTimer
    throw UnimplementedError();
  }
}
