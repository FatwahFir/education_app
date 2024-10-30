import 'package:job_landing_course/core/usecase/usecase.dart';
import 'package:job_landing_course/core/utils/typedef.dart';
import 'package:job_landing_course/features/on_boarding/domain/repositories/on_boarding_repository.dart';

class CacheFirstTimer extends UsecaseWithoutParams<void> {
  CacheFirstTimer({required OnBoardingRepository repo}) : _repo = repo;
  final OnBoardingRepository _repo;

  @override
  ResultFuture<void> call() async => _repo.cacheFisrtTimer();
}
