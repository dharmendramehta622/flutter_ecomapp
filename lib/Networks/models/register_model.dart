 

import 'dart:convert';
import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {
  
  final String firstName;
  final String lastName;
  final String email;
  final String password;
  final String confirmPassword;
  // final String? refer;

  const RegisterModel(
    this.firstName,
    this.lastName,
    this.email,
    this.password,
    this.confirmPassword,
    // this.refer,
  );
  @override
  List<Object?> get props => [firstName,lastName,email, password, confirmPassword];

  RegisterModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? password,
    String? confirmPassword,
    // String? password,
  }) {
    return RegisterModel(
      firstName ?? this.firstName,
      lastName ?? this.lastName,
      email ?? this.email,
      password ?? this.password,
      confirmPassword ?? this.confirmPassword
      // password ?? this.refer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
       "first_name":firstName,
  "last_name": '',
  "email": email.toLowerCase(),
  "password": password,
  "confirm_password":confirmPassword
      
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      map['first_name'] as String,
      map['last_name'] as String,
      map['email'] as String,
      map['password'] as String,
      map['confirm_password'] as String,
      
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
 