import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:new_project/blocs/authentication_bloc/authentication_state.dart';
import 'package:new_project/screens/home_screen.dart';
import 'package:new_project/screens/login_screen.dart';

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
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const HomeScreen()));
            break;
          case SessionStatus.expired:
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const LoginScreen()));
            break;
          default:
            throw UnimplementedError('Not a valid state');
        }
      },
      child: Scaffold(
        backgroundColor: Colors.deepPurple,
        body: Center(
          child: Image.asset(
            'assets/logos/logo.png',
            scale: 1.25, 
          ),
        ),
      ),
    );
  }
}
