import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Networks/services/auth_service.dart';
import 'package:new_project/blocs/register_bloc/register_event.dart';
import 'package:new_project/blocs/register_bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {

  final AuthService _authService = AuthService();
 
  TextEditingController emailController = TextEditingController(); 
  TextEditingController passwordController = TextEditingController(); 

  void clear() { 
    emailController.clear();
    passwordController.clear();
    passwordController.clear();
  }

  RegisterBloc() : super(RegisterInitial()) {

    //register text field changed
    on<RegisterTextFieldChangedEvent>((event, emit) {
    if (emailController.text.isEmpty) {
        emit(const RegisterEmailErrorState('Email address can\'t be empty.'));
      } else if (!EmailValidator.validate(emailController.text.trim())) {
        emit(const RegisterEmailErrorState(
            'Please enter a valid email address.'));
      } else if (passwordController.text.isEmpty) {
        emit(const RegisterPasswordErrorState('Password cannot be empty.'));
      } else {
        emit(RegisterFormValidState());
      }
    });

    //register started event
    on<RegisterStartedEvent>((event, emit) async {
      emit(RegisterLoading());
      final response =
          await _authService.registerWithEmailPassword(model: event.model);
      if (response.status) {
        clear();
        emit(  const RegisterSuccess('Registered successfully.'));
      } else {
        emit(const RegisterFailed('Registration failed.'));
      }
    });
  }
}
