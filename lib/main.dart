import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_px/AuthModule/bloc/login%20bloc/login_bloc.dart';
import 'package:flutter_px/AuthModule/screen/profile.dart';
import 'package:flutter_px/AuthModule/screen/upload.dart';
import 'App Start/screens/onboarding_screen.dart';
import 'AuthModule/screen/sign in.dart';
import 'App Start/screens/welcome_screen.dart';
import 'package:go_router/go_router.dart';
import 'AuthModule/bloc/profile bloc/datacollector_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => WelcomeScreen()),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => MyNewApp(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const HomeScreen(),
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

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ProfileBloc()),
        BlocProvider(create: (context) => LoginBloc())
      ],
      child: MaterialApp.router(
        routerConfig: _router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
