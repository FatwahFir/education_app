import 'package:equatable/equatable.dart';
import 'package:job_landing_course/core/enums/user_action_enum.dart';
import 'package:job_landing_course/core/usecase/usecase.dart';
import 'package:job_landing_course/core/utils/typedef.dart';
import 'package:job_landing_course/features/auth/domain/repositories/auth_repo.dart';

class UpdateUser extends UsecaseWithParams<void, UpdateUserParams> {
  UpdateUser({required AuthRepo repo}) : _repo = repo;

  final AuthRepo _repo;

  @override
  ResultFuture<void> call(UpdateUserParams params) => _repo.updateUser(
        action: params.action,
        userData: params.userData,
      );
}

class UpdateUserParams extends Equatable {
  const UpdateUserParams({required this.action, required this.userData});

  final UserActionEnum action;
  final dynamic userData;

  const UpdateUserParams.empty()
      : this(
          action: UserActionEnum.fullName,
          userData: '',
        );

  @override
  List<Object?> get props => [action, userData];
}
