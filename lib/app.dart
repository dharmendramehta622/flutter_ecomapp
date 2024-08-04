import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'resources/constants.dart';
import 'resources/routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: ScreenUtil.defaultSize,
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context,_) {
        return MaterialApp.router(
          title: 'Attendo',
          restorationScopeId: 'root',  
          routeInformationParser: GoRoutes.router.routeInformationParser,
          routeInformationProvider: GoRoutes.router.routeInformationProvider,
          routerDelegate: GoRoutes.router.routerDelegate,
          scrollBehavior: ScrollConfiguration.of(context).copyWith(),
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: kPrimary900),
            useMaterial3: true,
          ),
        );
      }
    );
  }
}
