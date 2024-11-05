import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_landing_course/features/auth/domain/repositories/auth_repo.dart';
import 'package:job_landing_course/features/auth/domain/usecases/forgot_password.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo repo;
  late ForgotPassword useCase;

  const tEmail = 'Test email';

  setUp(() {
    repo = AuthRepoMock();
    useCase = ForgotPassword(repo: repo);
  });

  test('Should call [AuthRepo.forgotPassword]', () async {
    when(
      () => repo.forgotPassword(
        any(),
      ),
    ).thenAnswer(
      (_) async => const Right(null),
    );

    final res = await useCase(tEmail);

    expect(
      res,
      equals(
        const Right<dynamic, void>(
          null,
        ),
      ),
    );

    verify(
      () => repo.forgotPassword(
        tEmail,
      ),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
