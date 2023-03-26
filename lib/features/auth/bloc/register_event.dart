import 'package:equatable/equatable.dart';

abstract class RegisterEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class RegisterRequestEvent extends RegisterEvent {
  RegisterRequestEvent() : super();
  @override
  List<Object?> get props => [];
}
