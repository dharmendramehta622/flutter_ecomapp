import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_project/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:new_project/blocs/clockin_bloc/clockin_bloc.dart';
import 'package:new_project/blocs/register_bloc/register_bloc.dart';
import 'app.dart';
import 'blocs/login_bloc/login_bloc.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc(),
        ),
        BlocProvider(
          create: (context) => ClockinBloc(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}


