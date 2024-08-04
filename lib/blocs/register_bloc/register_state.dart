import 'package:equatable/equatable.dart';

abstract class RegisterState extends Equatable {
  const RegisterState();

  @override
  List<Object> get props => [];
}

class RegisterInitial extends RegisterState {}

class RegisterLoading extends RegisterState {}

class RegisterEmailErrorState extends RegisterState {
  final String message;
  const RegisterEmailErrorState(this.message);
  @override
  List<Object> get props => [message];
}

class RegisterNameErrorState extends RegisterState {
  final String message;
  const RegisterNameErrorState(this.message);
  @override
  List<Object> get props => [message];
}

class RegisterPasswordErrorState extends RegisterState {
  final String message;
    final double strength;
  const RegisterPasswordErrorState(
    this.message,
    this.strength,
  );
  @override
  List<Object> get props => [message];
}

class RegisterNameError extends RegisterState {
  final String message;
 const RegisterNameError(this.message);

  @override
  List<Object> get props => [message];
}

class RegisterFormValidState extends RegisterState {}

class RegisterSuccess extends RegisterState {
  final String successMessage;

 const RegisterSuccess(this.successMessage);
}

class RegisterFailed extends RegisterState {
  final String message;

 const RegisterFailed(this.message);
}
