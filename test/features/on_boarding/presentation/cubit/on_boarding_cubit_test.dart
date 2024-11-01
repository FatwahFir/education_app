import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_landing_course/core/errors/failure.dart';
import 'package:job_landing_course/features/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:job_landing_course/features/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:job_landing_course/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:mocktail/mocktail.dart';

class MockCacheFirstTimer extends Mock implements CacheFirstTimer {}

class MockCheckIfUserIsFirstTimer extends Mock
    implements CheckIfUserIsFirstTimer {}

void main() {
  late CacheFirstTimer cacheFirstTimer;
  late CheckIfUserIsFirstTimer checkIfUserIsFirstTimer;
  late OnBoardingCubit cubit;

  setUp(
    () {
      cacheFirstTimer = MockCacheFirstTimer();
      checkIfUserIsFirstTimer = MockCheckIfUserIsFirstTimer();
      cubit = OnBoardingCubit(
        cacheFirstTimer: cacheFirstTimer,
        checkIfUserIsFirstTimer: checkIfUserIsFirstTimer,
      );
    },
  );

  test('Initial state should be [OnboardingInitial]', () {
    expect(cubit.state, const OnBoardingInitial());
  });

  group("cacheFirstTimer", () {
    blocTest("Should emit [CachingFirstTimer, UserCached]",
        build: () {
          when(() => cacheFirstTimer())
              .thenAnswer((_) async => const Right(null));
          return cubit;
        },
        act: (cubit) => cubit.cacheFirstTimer(),
        expect: () => const [
              CachingFirstTimer(),
              UserCached(),
            ],
        verify: (_) {
          verify(() => cacheFirstTimer()).called(1);
          verifyNoMoreInteractions(cacheFirstTimer);
        });

    blocTest(
      "Should emit [CachingFirstTimer, OnBoardingError]",
      build: () {
        when(() => cacheFirstTimer()).thenAnswer(
          (_) async => Left(
            CacheFailure(
              message: "Error when caching",
              statusCode: 4032,
            ),
          ),
        );
        return cubit;
      },
      act: (cubit) => cubit.cacheFirstTimer(),
      expect: () => const [
        CachingFirstTimer(),
        OnBoardingError(message: '4032 Error: Error when caching'),
      ],
      verify: (_) {
        verify(() => cacheFirstTimer()).called(1);
        verifyNoMoreInteractions(cacheFirstTimer);
      },
    );
  });

  group(
    "checkIfUserIsFirstTimer",
    () {
      blocTest(
        'Should emit [CheckingIfUserIsFirstTimer, OnBoardingStatus]',
        build: () {
          when(
            () => checkIfUserIsFirstTimer(),
          ).thenAnswer(
            (_) async => const Right(false),
          );
          return cubit;
        },
        act: (cubit) => cubit.checkIfUserIsFirstTimer(),
        expect: () => const [
          CheckingIfUserFirstTimer(),
          OnBoardingStatus(isFirstTimer: false),
        ],
        verify: (_) {
          verify(() => checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(checkIfUserIsFirstTimer);
        },
      );

      blocTest(
        'Should emit [CheckingIfUserIsFirstTimer, OnBoardingError]',
        build: () {
          when(
            () => checkIfUserIsFirstTimer(),
          ).thenAnswer(
            (_) async => Left(
              CacheFailure(
                message: 'Insufficient Storage',
                statusCode: 4032,
              ),
            ),
          );
          return cubit;
        },
        act: (cubit) => cubit.checkIfUserIsFirstTimer(),
        expect: () => const [
          CheckingIfUserFirstTimer(),
          OnBoardingError(message: '4032 Error: Insufficient Storage')
        ],
        verify: (_) {
          verify(() => checkIfUserIsFirstTimer()).called(1);
          verifyNoMoreInteractions(checkIfUserIsFirstTimer);
        },
      );
    },
  );
}
