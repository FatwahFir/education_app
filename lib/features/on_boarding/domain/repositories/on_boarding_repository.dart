import 'package:job_landing_course/core/utils/typedef.dart';

abstract class OnBoardingRepository {
  const OnBoardingRepository();

  ResultVoid cacheFisrtTimer();

  ResultFuture<bool> checkIfUserIsFirstTimer();
}
