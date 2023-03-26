import 'package:equatable/equatable.dart';

abstract class LoginEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoginRequestEvent extends LoginEvent {
  LoginRequestEvent() : super();
  @override
  List<Object?> get props => [];
}

class LogoutRequestEvent extends LoginEvent {
  @override
  List<Object?> get props => [];
}
