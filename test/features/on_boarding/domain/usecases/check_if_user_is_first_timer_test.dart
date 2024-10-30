import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_landing_course/features/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:job_landing_course/features/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:mocktail/mocktail.dart';

import 'on_boarding.mock.dart';

void main() {
  late OnBoardingRepository repo;
  late CheckIfUserIsFirstTimer useCase;

  setUp(() {
    repo = MockOnBoardingRepo();
    useCase = CheckIfUserIsFirstTimer(repo: repo);
  });

  test(
      "Should call a [Repo.checkIfUserIsFirstTimer] and return the right [boolean] data",
      () async {
    when(
      () => repo.checkIfUserIsFirstTimer(),
    ).thenAnswer(
      (_) async => const Right(true),
    );

    final res = await useCase();
    expect(
      res,
      equals(
        const Right<dynamic, bool>(true),
      ),
    );
    verify(() => repo.checkIfUserIsFirstTimer()).called(1);
    verifyNoMoreInteractions(repo);
  });
}
