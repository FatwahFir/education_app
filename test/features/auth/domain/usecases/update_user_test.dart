import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:job_landing_course/core/enums/user_action_enum.dart';
import 'package:job_landing_course/features/auth/domain/repositories/auth_repo.dart';
import 'package:job_landing_course/features/auth/domain/usecases/update_user.dart';
import 'package:mocktail/mocktail.dart';

import 'auth_repo.mock.dart';

void main() {
  late AuthRepo repo;
  late UpdateUser useCase;

  const tAction = UserActionEnum.fullName;
  const tFullName = 'Test full name';

  setUp(() {
    repo = AuthRepoMock();
    useCase = UpdateUser(repo: repo);
    registerFallbackValue(UserActionEnum.fullName);
  });

  test('Should call [AuthRepo.updateUser]', () async {
    when(
      () => repo.updateUser(
        action: any(named: 'action'),
        userData: any(named: 'userData'),
      ),
    ).thenAnswer(
      (_) async => const Right(null),
    );

    final res = await useCase(
      const UpdateUserParams(
        action: tAction,
        userData: tFullName,
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
      () => repo.updateUser(
        action: tAction,
        userData: tFullName,
      ),
    ).called(1);
    verifyNoMoreInteractions(repo);
  });
}
