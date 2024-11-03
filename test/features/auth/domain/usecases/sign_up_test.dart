import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_landing_course/features/auth/domain/repositories/auth_repo.dart';
import 'package:job_landing_course/features/auth/domain/usecases/sign_up.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo repo;
  late SignUp useCase;

  const tEmail = 'Test email';
  const tFullName = 'Test full name';
  const tPassword = 'Test password';

  setUp(() {
    repo = AuthRepoMock();
    useCase = SignUp(repo: repo);
  });

  test('Should call [AuthRepo.signUp]', () async {
    when(
      () => repo.signUp(
        email: any(named: 'email'),
        fullName: any(named: 'fullName'),
        password: any(named: 'password'),
      ),
    ).thenAnswer(
      (_) async => const Right(null),
    );

    final res = await useCase(
      const SignUpParams(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      ),
    );

    expect(
      res,
      equals(
        const Right<dynamic, void>(
          null,
        ),
      ),
    );

    verify(
      () => repo.signUp(
        email: tEmail,
        fullName: tFullName,
        password: tPassword,
      ),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
