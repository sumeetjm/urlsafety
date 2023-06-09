import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urlsafety/core/error/failures.dart';
import 'package:urlsafety/core/usecase/usecase.dart';
import 'package:urlsafety/features/auth/bloc/login_event.dart';
import 'package:urlsafety/features/auth/bloc/login_state.dart';
import 'package:urlsafety/features/auth/usecase/get_logged_in_user.dart';
import 'package:urlsafety/features/auth/usecase/login.dart';
import 'package:urlsafety/features/auth/usecase/logout.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final Login login;
  final GetLoggedInUser getLoggedInUser;
  final Logout logout;
  LoginBloc(
      {required this.login,
      required this.getLoggedInUser,
      required this.logout})
      : super(LoginInitial()) {
    on<LoginRequestEvent>((event, emit) async {
      final mayBeUser =
          await login(MultiParams([event.username, event.password]));
      mayBeUser.fold(
          (l) =>
              l is ServerFailure ? emit(LoginFailure()) : emit(LoginFailure()),
          (r) => r
              ? emit(LoginSuccess())
              : emit(LoginFailure('Username or password incorrect')));
    });
    on<LogoutRequestEvent>((event, emit) async {
      final mayBeVoid = await logout(NoParams());
      mayBeVoid.fold(
          (l) => emit(LogoutFailure()),
          (r) => r
              ? emit(LogoutSuccess())
              : emit(LogoutFailure('Unable to logout')));
    });
  }
}
