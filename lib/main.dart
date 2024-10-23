import 'package:flutter/material.dart';
import 'package:flutter_px/AuthModule/screen/profile.dart';
import 'package:flutter_px/AuthModule/screen/upload.dart';
import 'App Start/screens/onboarding_screen.dart';
import 'AuthModule/screen/sign in.dart';
import 'App Start/screens/welcome_screen.dart';
import 'package:go_router/go_router.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(
        path: '/', 
        builder: (context, state) => WelcomeScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => MyNewApp(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: '/profile',
        builder: (context, state) => PersonalInformationForm(),
      ),
      GoRoute(
        path: '/document',
        builder: (context, state) => UploadDocumentsScreen(),
      )
    ],
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}
