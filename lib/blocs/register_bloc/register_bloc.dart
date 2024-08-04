 

import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Networks/services/auth_service.dart';
import 'package:new_project/blocs/register_bloc/register_event.dart';
import 'package:new_project/blocs/register_bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  
  AuthService _authService = AuthService();
  
  late final String? emailError;
  late final String? passwordError;
  late final String? confirmPasswordError;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController nameController = TextEditingController();

  // RegExp regExp = new RegExp(pattern);
  double _strength = 0;

  String _displayText = 'Please enter a password';
  RegExp numReg = RegExp(r".*[0-9].*");
  RegExp letterReg = RegExp(r".*[A-Za-z].*");
  RegExp specReg = RegExp(r'[!@#$%^&*(),.?":{}|<>]');

  void clear() {
    emailController.clear();
    passwordController.clear();
  }

  RegisterBloc() : super(RegisterInitial()) {
    //register text field changed
    on<RegisterTextFieldChangedEvent>((event, emit) {
      _checkPassword(event.password);
      if (event.emailValue.isEmpty) {
        emit(const RegisterEmailErrorState('Email address can\'t be empty.'));
      } else if (!EmailValidator.validate(event.emailValue.trim())) {
        emit(const RegisterEmailErrorState('Please enter a valid email address.'));
      } else if (event.password.isEmpty) {
        emit(RegisterPasswordErrorState('Password cannot be empty', _strength));
      } else if (event.password.length < 8) {
        emit(RegisterPasswordErrorState(_displayText, _strength));
      } else if (_strength < .75) {
        emit(RegisterPasswordErrorState(_displayText, _strength));
      } else {
        emit(RegisterFormValidState());
      }
    });

    //register started event
    on<RegisterStartedEvent>((event, emit) async {
      emit(RegisterLoading());
      final _response =
          await _authService.registerWithEmailPassword(model: event.model);
      final message = _response.msg?.data['signup']['message'];
      if (_response.status) {
        clear();
        emit(RegisterSuccess(message));
      } else {
        emit(RegisterFailed(message));
      }
    });
  }

  void _checkPassword(String value) {
    String _password = value.trim();

    if (_password.isEmpty) {
      _strength = 0;
      print(_strength.toString());
      _displayText = 'Please enter you password.';
    } else if (_password.length < 6) {
      _strength = 1 / 4;
      print(_strength.toString());
      _displayText =
          'Password must be at least 7 characters long with letters and numbers';
    } else if (_password.length < 8) {
      _strength = 2 / 4;
      print(_strength.toString());
      _displayText = 'Your password is acceptable but not strong.';
    } else {
      if (!letterReg.hasMatch(_password) ||
          !numReg.hasMatch(_password) ||
          !specReg.hasMatch(_password)) {
        // Password length >= 8
        // But doesn't contain both letter and digit characters

        _strength = 2 / 4;
        print(_strength.toString());
        _displayText =
            'Your password needs to be at least 7 characters including letters,numbers and at least one special character e.g. #*^@.. ';
      } else if (letterReg.hasMatch(_password) &&
          numReg.hasMatch(_password) &&
          specReg.hasMatch(_password)) {
        // Password length >= 8
        // Password contains both letter and digit characters
        _strength = 1;
        print(_strength.toString());
        _displayText = 'Your password is strong. You are good to go.';
      }
    }
  }
}
