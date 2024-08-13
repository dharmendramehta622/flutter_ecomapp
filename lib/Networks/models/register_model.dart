 

import 'dart:convert';
import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {
   
  final String email;
  final String password;

  const RegisterModel( 
    this.email,
    this.password, 
  );
  @override
  List<Object?> get props => [ email, password];

  RegisterModel copyWith({ 
    String? email,
    String? password,  
  }) {
    return RegisterModel( 
      email ?? this.email,
      password ?? this.password, 
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{ 
      "email": email.toLowerCase(),
      "password": password,  
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel( 
      map['email'] as String,
      map['password'] as String, 
      
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
 