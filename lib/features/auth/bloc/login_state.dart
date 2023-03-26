import 'package:equatable/equatable.dart';

abstract class LoginState extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginInitial extends LoginState {
  @override
  List<Object?> get props => [];
}

class LoginSuccess extends LoginState {
  LoginSuccess() : super();

  @override
  List<Object?> get props => [];
}

class LoginFailure extends LoginState {
  String? message;
  LoginFailure([this.message]);
  @override
  List<Object?> get props => [message];
}

class LogoutSuccess extends LoginState {
  @override
  List<Object?> get props => [];
}

class LogoutFailure extends LoginState {
  String? message;
  LogoutFailure([this.message]);
  @override
  List<Object?> get props => [message];
}
