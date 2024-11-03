import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_landing_course/features/auth/domain/entities/local_user.dart';
import 'package:job_landing_course/features/auth/domain/repositories/auth_repo.dart';
import 'package:job_landing_course/features/auth/domain/usecases/sign_in.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo repo;
  late SignIn useCase;

  const tEmail = 'Test email';
  const tPassword = 'Test password';

  setUp(() {
    repo = AuthRepoMock();
    useCase = SignIn(repo: repo);
  });

  const tUser = LocalUser.empty();

  test('Should call [AuthRepo.signIn] & return a [LocalUser]', () async {
    when(
      () => repo.signIn(
        email: any(named: 'email'),
        password: any(
          named: 'password',
        ),
      ),
    ).thenAnswer(
      (_) async => const Right(tUser),
    );

    final res = await useCase(
      const SignInParams(
        email: tEmail,
        password: tPassword,
      ),
    );

    expect(
      res,
      equals(
        const Right<dynamic, LocalUser>(
          tUser,
        ),
      ),
    );

    verify(
      () => repo.signIn(
        email: tEmail,
        password: tPassword,
      ),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
