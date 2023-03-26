import 'dart:async';

import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/network/network_info.dart';
import 'features/auth/bloc/auth_bloc.dart';
import 'features/auth/bloc/login_bloc.dart';
import 'features/auth/bloc/register_bloc.dart';
import 'features/auth/datasource/auth_datasource.dart';
import 'features/auth/repository/auth_repository.dart';
import 'features/auth/usecase/get_logged_in_user.dart';
import 'features/auth/usecase/login.dart';
import 'features/auth/usecase/logout.dart';
import 'features/auth/usecase/register.dart';

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Number Trivia
  // Bloc
  sl.registerFactory(
      () => AuthBloc(login: sl(), getLoggedInUser: sl(), logout: sl()));
  sl.registerFactory(
      () => LoginBloc(login: sl(), getLoggedInUser: sl(), logout: sl()));
  sl.registerFactory(
      () => RegisterBloc(register: sl(), getLoggedInUser: sl(), logout: sl()));

  // Use cases*/
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Register(sl()));
  sl.registerLazySingleton(() => GetLoggedInUser(sl()));
  sl.registerLazySingleton(() => Logout(sl()));

  // Repository*/
  sl.registerLazySingleton(() => AuthRepository(authDatasource: sl()));

  // Data sources*/
  sl.registerLazySingleton(() => AuthDatasource(sl()));
  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => InternetConnectionChecker.createInstance(
        checkTimeout: const Duration(seconds: 1),
        checkInterval: const Duration(seconds: 1),
      ));
}
