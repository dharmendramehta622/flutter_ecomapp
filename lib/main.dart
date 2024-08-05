import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl_standalone.dart';
import 'package:new_project/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:new_project/blocs/clockin_bloc/clockin_bloc.dart';
import 'package:new_project/blocs/register_bloc/register_bloc.dart';

import 'app.dart';
import 'blocs/authentication_bloc/authentication_event.dart';
import 'blocs/clockin_status_bloc/clockin_status_bloc.dart';
import 'blocs/location_bloc/location_bloc.dart';
import 'blocs/login_bloc/login_bloc.dart';

void main() async {

   // Ensure WidgetsFlutterBinding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize date formatting
  await initializeDateFormatting('en', null);
  
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
          create: (context) => LocationBloc()..add(LoadLocation()),
        ),
        BlocProvider(
          create: (context) => ClockinStatusBloc()..add(CheckClockIn()),
        ),
        BlocProvider(
          create: (context) => AuthenticationBloc()..add(AuthenticationStatusChanged()),
        ),
        BlocProvider(
          create: (context) => ClockinBloc()..add(LoadClockInList()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}


