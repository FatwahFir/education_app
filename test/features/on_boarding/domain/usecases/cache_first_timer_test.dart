import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_landing_course/core/errors/failure.dart';
import 'package:job_landing_course/features/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:job_landing_course/features/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding.mock.dart';

void main() {
  late OnBoardingRepository repo;
  late CacheFirstTimer useCase;

  setUp(() {
    repo = MockOnBoardingRepo();
    useCase = CacheFirstTimer(repo: repo);
  });

  test("Should call a [Repo.cacheFirsttimer] and return the right data",
      () async {
    when(
      () => repo.cacheFirstTimer(),
    ).thenAnswer(
      (_) async => Left(
        ServerFailure(message: "Unknown error", statusCode: 500),
      ),
    );

    final res = await useCase();
    expect(
      res,
      equals(
        Left<Failure, dynamic>(
          ServerFailure(message: "Unknown error", statusCode: 500),
        ),
      ),
    );
    verify(() => repo.cacheFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
