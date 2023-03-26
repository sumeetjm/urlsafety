import 'package:equatable/equatable.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  @override
  List<Object?> get props => [];
}

class Authenticated extends AuthState {
  Authenticated() : super();
  @override
  List<Object> get props => [];
}

class Unauthenticated extends AuthState {
  @override
  String toString() => 'Unauthenticated';
}
