import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:urlsafety/core/error/failures.dart';
import 'package:urlsafety/features/auth/bloc/register_event.dart';
import 'package:urlsafety/features/auth/bloc/register_state.dart';
import 'package:urlsafety/features/auth/usecase/get_logged_in_user.dart';
import 'package:urlsafety/features/auth/usecase/logout.dart';
import 'package:urlsafety/features/auth/usecase/register.dart';

import '../../../../core/usecase/usecase.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final Register register;
  final GetLoggedInUser getLoggedInUser;
  final Logout logout;
  RegisterBloc(
      {required this.register,
      required this.getLoggedInUser,
      required this.logout})
      : super(RegisterInitial()) {
    on<RegisterRequestEvent>((event, emit) async {
      final mayBeUser =
          await register(MultiParams([event.username, event.password]));
      mayBeUser.fold(
          (l) => emit(RegisterFailure('Unable to register')),
          (r) => r
              ? emit(RegisterSuccess())
              : emit(RegisterFailure('User already exist')));
    });
  }
}
