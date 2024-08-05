import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Networks/services/auth_service.dart';
import 'package:new_project/blocs/register_bloc/register_event.dart';
import 'package:new_project/blocs/register_bloc/register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final AuthService _authService = AuthService();

  late final String? emailError;
  late final String? passwordError;
  late final String? confirmPasswordError;
  TextEditingController emailController = TextEditingController();
  TextEditingController dobController = TextEditingController();

  TextEditingController passwordController = TextEditingController();
  TextEditingController fnameController = TextEditingController();
  TextEditingController lnameController = TextEditingController();

  void clear() {
    fnameController.clear();
    lnameController.clear();
    emailController.clear();
    passwordController.clear();
    dobController.clear();
  }

  RegisterBloc() : super(RegisterInitial()) {
    //register text field changed
    on<RegisterTextFieldChangedEvent>((event, emit) {
      if (fnameController.text.isEmpty) {
        emit(const RegisterFNameErrorState('First name can\'t be empty.'));
      } else if (lnameController.text.isEmpty) {
        emit(const RegisterLNameErrorState('Last name can\'t be empty.'));
      } else if (emailController.text.isEmpty) {
        emit(const RegisterEmailErrorState('Email address can\'t be empty.'));
      } else if (!EmailValidator.validate(emailController.text.trim())) {
        emit(const RegisterEmailErrorState(
            'Please enter a valid email address.'));
      } else if (dobController.text.isEmpty) {
        emit(const RegisterDobErrorState('Date of birth cannot be empty.'));
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
        var message = response.msg?.data["data"];
        clear();
        emit(  RegisterSuccess(message));
      } else {
        const message = 'Email already exists in our system.';
        emit(const RegisterFailed(message));
      }
    });
  }
}
