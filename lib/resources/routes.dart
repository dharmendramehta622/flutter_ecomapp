import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:new_project/screens/home_screen.dart';
import 'package:new_project/screens/login_screen.dart';
import 'package:new_project/screens/signup_screen.dart';

import '../screens/splash_screen.dart';

class Routes {
  static String landing = '/landing';
  static String register = '/register';
  static String login = '/login';
  static String splash = '/';
}

class GoRouterObserver extends NavigatorObserver {
  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // print('MyTest didPush: $route');
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // print('MyTest didPop: $route');
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    // print('MyTest didRemove: $route');
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    // print('MyTest didReplace: $newRoute');
  }
}

mixin GoRoutes {
  // Define your routes using GoRouter
  static final List<RouteBase> routes = [
    GoRoute(
      path: Routes.splash,
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: Routes.register,
      builder: (context, state) => const SignUpScreen(),
    ),
    GoRoute(
      path: Routes.login,
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: Routes.landing,
      builder: (context, state) => const HomeScreen(),
    ),
  ];

//router config

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  static GlobalKey<NavigatorState> shellNavigatorKey =
      GlobalKey<NavigatorState>();

  static final router = GoRouter(
    navigatorKey: navigatorKey,
    initialLocation: '/',
    redirectLimit: 3, 
    routes: routes,
    observers: [
      GoRouterObserver(),
    ],
  );
}
