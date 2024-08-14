import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'resources/constants.dart';
import 'resources/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    ThemeData theme = ThemeData(
      primarySwatch: const MaterialColor(
        0xff2264DF,
        <int, Color>{
          25: kPrimary25,
          50: kPrimary50,
          100: kPrimary100,
          200: kPrimary200,
          300: kPrimary300,
          400: kPrimary400,
          500: kPrimary500,
          600: kPrimary600,
          700: kPrimary700,
          800: kPrimary800,
          900: kPrimary900,
        },
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(color: kPrimary700),
      // fontFamily: 'Google',
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
          TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
        },
      ),
    );

    return ScreenUtilInit(
        designSize: ScreenUtil.defaultSize,
        minTextAdapt: true,
        splitScreenMode: true,
        builder: (context, _) {
          return MaterialApp.router(
            title: 'Ecommerce',
            restorationScopeId: 'root',
            routeInformationParser: GoRoutes.router.routeInformationParser,
            routeInformationProvider: GoRoutes.router.routeInformationProvider,
            routerDelegate: GoRoutes.router.routerDelegate,
            scrollBehavior: ScrollConfiguration.of(context).copyWith(),
            debugShowCheckedModeBanner: false,
            theme: theme,
          );
        });
  }
}
