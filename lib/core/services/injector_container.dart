// import 'package:get_it/get_it.dart';
// import 'package:http/http.dart' as http;

// final sl = GetIt.instance;

// Future<void> init() async {
//   sl
//     //App logic (state management)
//     ..registerFactory(
//       () => AuthenticationCubit(
//         createUser: sl(),
//         getUsers: sl(),
//       ),
//     )

//     //Usecases
//     ..registerLazySingleton(
//       () => CreateUser(
//         sl(),
//       ),
//     )
//     ..registerLazySingleton(
//       () => GetUsers(
//         sl(),
//       ),
//     )

//     //Repositories
//     ..registerLazySingleton<AuthenticationRepository>(
//       () => AuthenticationRepositoryImplementation(
//         datasource: sl(),
//       ),
//     )

//     //Datasources
//     ..registerLazySingleton<AuthenticationRemoteDatasource>(
//       () => AuthRemoteDataSrcImpl(
//         client: sl(),
//       ),
//     )

//     //External Dependencies
//     ..registerLazySingleton(
//       http.Client.new,
//     );
// }
