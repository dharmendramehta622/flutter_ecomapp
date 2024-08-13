import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:new_project/blocs/authentication_bloc/authentication_bloc.dart';
import 'package:new_project/blocs/product_bloc/product_bloc.dart';
import 'package:new_project/blocs/register_bloc/register_bloc.dart';

import 'app.dart';
import 'blocs/authentication_bloc/authentication_event.dart';
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
          create: (context) => ProductBloc()..add(ProductFetched()),
        ),
        BlocProvider(
          create: (context) =>
              AuthenticationBloc()..add(AuthenticationStatusChanged()),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
