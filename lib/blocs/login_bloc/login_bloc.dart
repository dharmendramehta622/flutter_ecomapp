import 'package:bloc/bloc.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:new_project/Networks/BaseApiServices.dart';
import 'package:new_project/Networks/StorageServices.dart';
import 'package:new_project/Networks/services/auth_service.dart';
import 'package:new_project/blocs/login_bloc/login_event.dart';
import 'package:new_project/blocs/login_bloc/login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  
  final AuthService _authService = AuthService();
  late String message;
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  void _clear() {
    emailController.clear();
    passwordController.clear();
  }

  LoginBloc() : super(LoginInitial()) {

    on<LoginStartedEvent>((event, emit) async {
      emit(LoginLoading());
      final ApiResponse response =
          await _authService.loginWithEmail(event.model);
      message = 'Logged in successfully.';
      if (response.status) {
        _clear();
        add(ClientLoginSuccessEvent(message));
      } else {
        final message = response.msg?.data['data'];
        emit(LoginFailedState(message));
      }
    });

    on<ClientLoginSuccessEvent>((event, emit) async {
      emit(ClientLoginSucessState(event.message));
    });

    on<AdminLoginSuccessEvent>((event, emit) async {
      emit(AdminLoginSucessState(event.message, event.sessionInfo));
    });

    on<LoginFailedEvent>((event, emit) {
      emit(LoginFailedState(event.message));
    });

    on<LoginTextFieldChangedEvent>((event, emit) {
      if (event.email.isEmpty) {
        emit(const LoginEmailErrorState('Email  can\'t be empty.'));
      } else if (!EmailValidator.validate(event.email.trim())) {
        emit(const LoginEmailErrorState('Please enter a valid email address.'));
      } else if (event.password.isEmpty) {
        emit(const LoginPasswordErrorState('Password cannot be empty'));
      } else if (event.password.length < 8) {
        emit(const LoginPasswordErrorState(
            'Please enter a password 8 characters long.'));
      } else {
        emit(LoginFormValid());
      }
    });

    on<LogoutRequested>((event, emit) async {
      await LocalStorageService.instance
          .delete(LocalStorageServiceItems.userToken);
      emit(const LogoutSuccessState('Logged out successfully'));
    });

  }
}
