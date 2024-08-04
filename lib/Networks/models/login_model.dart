import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginModel extends Equatable {
  final String email;
  final String password;
  final bool remember;

  const LoginModel(
    this.email,
    this.password,
    this.remember,
  );
  @override
  List<Object> get props => [email, password,remember];

  LoginModel copyWith({
    String? email,
    String? password,
    bool? remember,
  }) {
    return LoginModel(
      email ?? this.email,
      password ?? this.password,
      remember ?? this.remember,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'email': email.toLowerCase(),
      'password': password,
      'remember': remember,
    };
  }

  factory LoginModel.fromMap(Map<String, dynamic> map) {
    return LoginModel(
      map['email'] as String,
      map['password'] as String,
      map['remember'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginModel.fromJson(String source) =>
      LoginModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
