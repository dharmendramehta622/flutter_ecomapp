import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:new_project/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:new_project/blocs/authentication_bloc/authentication_state.dart';
import 'package:new_project/resources/routes.dart';

import '../resources/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (context, state) {
        switch (state.status) {
          case SessionStatus.initial:
            break;
          case SessionStatus.valid:
            context.go(Routes.landing);
            break;
          case SessionStatus.expired:
            context.go(Routes.login);
            break;
          default:
            throw UnimplementedError('Not a valid state');
        }
      },
      child: Container(
        color: kPrimary800,
        child: Scaffold(
          backgroundColor: kWhite,
          body: Center(
            child: Image.asset(
              'assets/logos/logo.png',
              scale: 1.25,
            ),
          ),
        ),
      ),
    );
  }
}
