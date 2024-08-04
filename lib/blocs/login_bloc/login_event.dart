 

import 'package:equatable/equatable.dart';
import 'package:new_project/Networks/models/login_model.dart';
import 'package:new_project/Networks/models/session_info.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginTextFieldChangedEvent extends LoginEvent {
  
  final String email;
  final String password;
  const LoginTextFieldChangedEvent(this.email,this.password);
}

class LogoutRequested extends LoginEvent {}

class LoginStartedEvent extends LoginEvent {
  final LoginModel model;

 const LoginStartedEvent(this.model);
}

class AdminLoginSuccessEvent extends LoginEvent {
  final String message;
  final SessionInfo sessionInfo;
 const AdminLoginSuccessEvent(this.message, this.sessionInfo);
}

class ClientLoginSuccessEvent extends LoginEvent {
  final String message;

  const ClientLoginSuccessEvent(this.message);
}

class LogoutSuccessEvent extends LoginEvent {
  final String message;

  const LogoutSuccessEvent(this.message);
}

class LoginFailedEvent extends LoginEvent {
  final String message;

 const LoginFailedEvent(this.message);
}

class AdminProfileNotSet extends LoginEvent {}

class ClientProfileNotSet extends LoginEvent {}
