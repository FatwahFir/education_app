import 'package:job_landing_course/core/utils/typedef.dart';

abstract class OnBoardingRepository {
  const OnBoardingRepository();

  ResultVoid cacheFirstTimer();

  ResultFuture<bool> checkIfUserIsFirstTimer();
}
