import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class CheckLoginEvent extends AuthEvent {}

class LoggedOutEvent extends AuthEvent {}

class LoggedInEvent extends AuthEvent {
  LoggedInEvent();
  @override
  String toString() => 'LoggedIn';
}
