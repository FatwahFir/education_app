import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:job_landing_course/features/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:job_landing_course/features/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';

part 'on_boarding_state.dart';

class OnBoardingCubit extends Cubit<OnBoardingState> {
  OnBoardingCubit(
      {required CacheFirstTimer cacheFirstTimer,
      required CheckIfUserIsFirstTimer checkIfUserIsFirstTimer})
      : _cacheFirstTimer = cacheFirstTimer,
        _checkIfUserIsFirstTimer = checkIfUserIsFirstTimer,
        super(const OnBoardingInitial());

  final CacheFirstTimer _cacheFirstTimer;
  final CheckIfUserIsFirstTimer _checkIfUserIsFirstTimer;

  Future<void> cacheFirstTimer() async {
    emit(const CachingFirstTimer());
    final res = await _cacheFirstTimer();

    res.fold(
      (failure) => emit(OnBoardingError(message: failure.errorMessage)),
      (_) => emit(
        const UserCached(),
      ),
    );
  }

  Future<void> checkIfUserIsFirstTimer() async {
    emit(const CheckingIfUserFirstTimer());

    final res = await _checkIfUserIsFirstTimer();

    res.fold(
      (failure) => emit(OnBoardingError(message: failure.errorMessage)),
      (status) => emit(
        OnBoardingStatus(
          isFirstTimer: status,
        ),
      ),
    );
  }
}
