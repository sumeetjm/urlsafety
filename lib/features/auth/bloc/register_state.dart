import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterInitial extends RegisterState {
  @override
  List<Object?> get props => [];
}

class RegisterSuccess extends RegisterState {
  RegisterSuccess() : super();

  @override
  List<Object?> get props => [];
}

class RegisterFailure extends RegisterState {
  final String? message;
  RegisterFailure([this.message]);
  @override
  List<Object?> get props => [message];
}
