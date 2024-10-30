import 'package:flutter_test/flutter_test.dart';
import 'package:job_landing_course/core/errors/exceptions.dart';
import 'package:job_landing_course/features/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPrefs extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences prefs;
  late OnBoardingLocalDataSource dataSource;

  setUp(() {
    prefs = MockSharedPrefs();
    dataSource = OnBoardingLocalDataSrcImpl(prefs: prefs);
  });

  group(
    'cacheFirstTimer',
    () {
      test(
        'Should call [SharedPreferences] to cache the data',
        () async {
          when(
            () => prefs.setBool(
              any(),
              any(),
            ),
          ).thenAnswer(
            (_) async => true,
          );

          await dataSource.cacheFirstTimer();

          verify(
            () => prefs.setBool(
              kFirstTimerKey,
              false,
            ),
          ).called(1);

          verifyNoMoreInteractions(prefs);
        },
      );

      test(
        'Should throws an [Exceptions] when failed to cache the data',
        () async {
          when(
            () => prefs.setBool(
              any(),
              any(),
            ),
          ).thenThrow(Exception());

          final call = dataSource.cacheFirstTimer;

          expect(
            call,
            throwsA(
              isA<CacheException>(),
            ),
          );

          verify(
            () => prefs.setBool(
              kFirstTimerKey,
              false,
            ),
          ).called(1);

          verifyNoMoreInteractions(prefs);
        },
      );
    },
  );

  group(
    'checkIfUserIsFirstTimer',
    () {
      test(
        'Should call [SharedPreferences] to getStatus of user from storage '
        'when data is exists',
        () async {
          when(
            () => prefs.getBool(
              any(),
            ),
          ).thenReturn(false);

          final res = await dataSource.checkIfUserIsFirstTimer();

          expect(res, false);

          verify(
            () => prefs.getBool(
              kFirstTimerKey,
            ),
          ).called(1);

          verifyNoMoreInteractions(prefs);
        },
      );

      test(
        'Should return true when theres no data in storage',
        () async {
          when(
            () => prefs.getBool(
              any(),
            ),
          ).thenReturn(null);

          final res = await dataSource.checkIfUserIsFirstTimer();

          expect(res, true);

          verify(
            () => prefs.getBool(
              kFirstTimerKey,
            ),
          ).called(1);

          verifyNoMoreInteractions(prefs);
        },
      );

      test(
        'Should return a [CacheException] when theres an error occured',
        () async {
          when(
            () => prefs.getBool(
              any(),
            ),
          ).thenThrow(Exception());

          final call = dataSource.checkIfUserIsFirstTimer;

          expect(
            call,
            throwsA(
              isA<CacheException>(),
            ),
          );

          verify(
            () => prefs.getBool(
              kFirstTimerKey,
            ),
          ).called(1);

          verifyNoMoreInteractions(prefs);
        },
      );
    },
  );
}
