import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_landing_course/core/errors/exceptions.dart';
import 'package:job_landing_course/core/errors/failure.dart';
import 'package:job_landing_course/features/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:job_landing_course/features/on_boarding/data/repositories/on_boarding_repo_impl.dart';
import 'package:job_landing_course/features/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:mocktail/mocktail.dart';

class MockLocalDataSrc extends Mock implements OnBoardingLocalDataSource {}

void main() {
  late OnBoardingLocalDataSource dataSource;
  late OnBoardingRepository repo;

  setUp(() {
    dataSource = MockLocalDataSrc();
    repo = OnBoardingRepoImpl(dataSource: dataSource);
  });

  test('Should subclass of [OnBoardingRepository]', () {
    expect(
      repo,
      isA<OnBoardingRepository>(),
    );
  });

  group(
    "cacheFirstTimer",
    () {
      test(
        "Should complete successfully when call [localDataSrc.cacheFirtsTimer]",
        () async {
          when(
            () => dataSource.cacheFirstTimer(),
          ).thenAnswer(
            (_) async => Future.value,
          );

          final res = await repo.cacheFirstTimer();

          expect(
            res,
            equals(
              const Right<dynamic, void>(null),
            ),
          );
        },
      );

      test(
        "Should return [CacheException] when call [localDataSrc.cacheFirtsTimer] "
        'not successful',
        () async {
          when(
            () => dataSource.cacheFirstTimer(),
          ).thenThrow(
            const CacheException(message: "Insufficient storage"),
          );

          final res = await repo.cacheFirstTimer();

          expect(
            res,
            equals(
              Left<CacheFailure, dynamic>(
                CacheFailure(
                  message: 'Insufficient storage',
                  statusCode: 500,
                ),
              ),
            ),
          );

          verify(() => dataSource.cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );
    },
  );

  group(
    'checkIfUserIsFirstTimer',
    () {
      test(
        'Should return true if user is first timer',
        () async {
          when(
            () => dataSource.checkIfUserIsFirstTimer(),
          ).thenAnswer(
            (_) async => Future.value(true),
          );

          final res = await repo.checkIfUserIsFirstTimer();

          expect(
            res,
            equals(
              const Right<dynamic, bool>(true),
            ),
          );

          verify(() => dataSource.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );

      test(
        'Should return true if user is not first timer',
        () async {
          when(
            () => dataSource.checkIfUserIsFirstTimer(),
          ).thenAnswer(
            (_) async => Future.value(false),
          );

          final res = await repo.checkIfUserIsFirstTimer();

          expect(
            res,
            equals(
              const Right<dynamic, bool>(false),
            ),
          );

          verify(() => dataSource.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );

      test(
        'Should return [CacheException] when error checking user',
        () async {
          when(
            () => dataSource.checkIfUserIsFirstTimer(),
          ).thenThrow(
            const CacheException(message: "Insufficient storage"),
          );

          final res = await repo.checkIfUserIsFirstTimer();

          expect(
            res,
            equals(
              Left<CacheFailure, dynamic>(
                CacheFailure(
                  message: 'Insufficient storage',
                  statusCode: 500,
                ),
              ),
            ),
          );

          verify(() => dataSource.checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(dataSource);
        },
      );
    },
  );
}
