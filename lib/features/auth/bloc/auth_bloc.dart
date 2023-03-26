import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urlsafety/features/auth/bloc/auth_event.dart';
import 'package:urlsafety/features/auth/bloc/auth_state.dart';

import '../../../../core/usecase/usecase.dart';
import '../usecase/get_logged_in_user.dart';
import '../usecase/login.dart';
import '../usecase/logout.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login login;
  final GetLoggedInUser getLoggedInUser;
  final Logout logout;
  AuthBloc(
      {required this.login,
      required this.getLoggedInUser,
      required this.logout})
      : super(AuthInitial()) {
    on<LoggedInEvent>((event, emit) async {
      emit(Authenticated());
    });
    on<CheckLoginEvent>((event, emit) async {
      final mayBeUser = await getLoggedInUser(NoParams());
      mayBeUser.fold((l) => emit(Unauthenticated()),
          (r) => r == false ? emit(Unauthenticated()) : emit(Authenticated()));
    });
    on<LoggedOutEvent>((event, emit) async {
      emit(Unauthenticated());
    });
  }
}
