 

import 'package:equatable/equatable.dart';

abstract class AuthenticationEvent extends Equatable {
  const AuthenticationEvent();

  @override
  List<Object> get props => [];
}

class AuthenticationStatusChanged extends AuthenticationEvent {}
 
class AuthenticationClientSessionEvent extends AuthenticationEvent {
  final dynamic sessionInfo;

  const AuthenticationClientSessionEvent(this.sessionInfo);
  @override
  List<Object> get props => [sessionInfo];
}

class AuthenticationUnknownSessionEvent extends AuthenticationEvent {}
 
class AuthenticationLogoutRequested extends AuthenticationEvent {}

class AuthenticationAccountDeleteRequested extends AuthenticationEvent {}
