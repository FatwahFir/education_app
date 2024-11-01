import 'package:get_it/get_it.dart';
import 'package:job_landing_course/features/on_boarding/data/datasources/on_boarding_local_data_source.dart';
import 'package:job_landing_course/features/on_boarding/data/repositories/on_boarding_repo_impl.dart';
import 'package:job_landing_course/features/on_boarding/domain/repositories/on_boarding_repository.dart';
import 'package:job_landing_course/features/on_boarding/domain/usecases/cache_first_timer.dart';
import 'package:job_landing_course/features/on_boarding/domain/usecases/check_if_user_is_first_timer.dart';
import 'package:job_landing_course/features/on_boarding/presentation/cubit/on_boarding_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  final prefs = await SharedPreferences.getInstance();

  sl
    //App logic (state management)
    ..registerFactory(
      () => OnBoardingCubit(
        cacheFirstTimer: sl(),
        checkIfUserIsFirstTimer: sl(),
      ),
    )

    //Usecases
    ..registerLazySingleton(
      () => CacheFirstTimer(
        repo: sl(),
      ),
    )
    ..registerLazySingleton(
      () => CheckIfUserIsFirstTimer(
        repo: sl(),
      ),
    )

    //Repositories
    ..registerLazySingleton<OnBoardingRepository>(
      () => OnBoardingRepoImpl(
        dataSource: sl(),
      ),
    )

    //Datasources
    ..registerLazySingleton<OnBoardingLocalDataSource>(
      () => OnBoardingLocalDataSrcImpl(
        prefs: sl(),
      ),
    )

    //External Dependencies
    ..registerLazySingleton(() => prefs);
}
