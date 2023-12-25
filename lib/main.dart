import 'package:final_proj/Widgets/auth_page.dart';
import 'package:final_proj/cubits/aut_states.dart';
import 'package:final_proj/cubits/auth_cubit.dart';
import 'package:final_proj/cubits/store_cubit.dart';
import 'package:final_proj/screens/splash_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:final_proj/home_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  final sharedPreferences = await SharedPreferences.getInstance();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (context) => AuthCubit(sharedPreferences),
        ),
        BlocProvider<StoreCubit>(
          create: (context) => StoreCubit(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: BlocListener<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthInitial) {
            // Show the splash screen if the user is not authenticated
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const SplashScreen()),
            );
          } else if (state is AuthSuccess) {
            // If authenticated, show the home page
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const HomePage()),
            );
          }
        },
        child:
            const SplashScreen(), 
      ),
      routes: {
        AuthPage.id: (context) => AuthPage(),
        HomePage.id: (context) => const HomePage(),
      },
    );
  }
}
