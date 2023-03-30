import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterRequestEvent extends RegisterEvent {
  final String username;
  final String password;
  RegisterRequestEvent(this.username, this.password) : super();
  @override
  List<Object?> get props => [];
}
