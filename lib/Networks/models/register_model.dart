 

import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegisterModel extends Equatable {
  
  final String firstName;
  final String lastName;
  final String email;
  final String dob;

  const RegisterModel(
    this.firstName,
    this.lastName,
    this.email,
    this.dob,
    // this.refer,
  );
  @override
  List<Object?> get props => [firstName,lastName,email, dob];

  RegisterModel copyWith({
    String? firstName,
    String? lastName,
    String? email,
    String? dob,  
  }) {
    return RegisterModel(
      firstName ?? this.firstName,
      lastName ?? this.lastName,
      email ?? this.email,
      dob ?? this.dob, 
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "first_name":firstName,
      "last_name": lastName,
      "email": email.toLowerCase(),
      "dob": dob,  
    };
  }

  factory RegisterModel.fromMap(Map<String, dynamic> map) {
    return RegisterModel(
      map['first_name'] as String,
      map['last_name'] as String,
      map['email'] as String,
      map['dob'] as String, 
      
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterModel.fromJson(String source) =>
      RegisterModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
 