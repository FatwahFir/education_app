part of 'injector_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _onBoardingInit();
  await _authInit();
}

Future<void> _authInit() async {
  sl
    ..registerFactory(
      () => AuthBloc(
        forgotPassword: sl(),
        signIn: sl(),
        signUp: sl(),
        updateUser: sl(),
      ),
    )
    ..registerLazySingleton(
      () => ForgotPassword(
        repo: sl(),
      ),
    )
    ..registerLazySingleton(
      () => SignIn(
        repo: sl(),
      ),
    )
    ..registerLazySingleton(
      () => SignUp(
        repo: sl(),
      ),
    )
    ..registerLazySingleton(
      () => UpdateUser(
        repo: sl(),
      ),
    )
    ..registerLazySingleton<AuthRepo>(
      () => AuthRepoImpl(
        remoteDataSrc: sl(),
      ),
    )
    ..registerLazySingleton<AuthRemoteDataSrc>(
      () => AuthRemoteDataSrcImpl(
        authClient: sl(),
        cloudStoreClient: sl(),
        dbClient: sl(),
      ),
    )
    ..registerLazySingleton(() => FirebaseAuth.instance)
    ..registerLazySingleton(() => FirebaseFirestore.instance)
    ..registerLazySingleton(() => FirebaseStorage.instance);
}

Future<void> _onBoardingInit() async {
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
