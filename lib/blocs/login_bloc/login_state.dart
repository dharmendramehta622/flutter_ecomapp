
import 'package:equatable/equatable.dart';
import 'package:new_project/Networks/models/session_info.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {}

class LoginEmailErrorState extends LoginState {
  final String message;
 const LoginEmailErrorState(this.message);
}

class LoginPasswordErrorState extends LoginState {
  final String message;
 const LoginPasswordErrorState(this.message);
}

class LoginFormValid extends LoginState {}

class LoginInitialState extends LoginState {}

class LogoutSuccessState extends LoginState {
  final String message;

const  LogoutSuccessState(this.message);
}

class AdminLoginSucessState extends LoginState {
  final String message;
  final SessionInfo sessionInfo;
 const AdminLoginSucessState(this.message, this.sessionInfo);
}

class ClientLoginSucessState extends LoginState {
  final String message;

  const ClientLoginSucessState(this.message);
}

class LoginLoadingState extends LoginState {}

class LoginClientVerifyOTPState extends LoginState {
  final String message;

 const LoginClientVerifyOTPState(this.message);
  @override
  List<Object> get props => [message];
}

class LoginFailedState extends LoginState {
  final String message;
 const LoginFailedState(this.message);
}

class MerchantLoginProfileNotSetState extends LoginState {}

class ClientLoginProfileNotSetState extends LoginState {}
