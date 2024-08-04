 

import 'package:equatable/equatable.dart';
import 'package:new_project/Networks/models/session_info.dart';

enum SessionStatus {
  initial,
  loading,
  valid,
  expired,
}

class AuthenticationState extends Equatable {
  final SessionStatus status;
  final String message;
  final SessionInfo? sessionInfo;

  AuthenticationState({this.status = SessionStatus.initial,this.message= '',this.sessionInfo});

  @override
  List<Object?> get props => [status, sessionInfo,message];

  AuthenticationState copyWith({
    SessionStatus? status,
    String? message,
    SessionInfo? sessionInfo,
  }) {
    return AuthenticationState(
      status: status ?? this.status,
      message: message ?? this.message,
      sessionInfo: sessionInfo ?? this.sessionInfo,
    );
  }
}
