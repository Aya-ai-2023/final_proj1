
//import 'package:firebase_core/firebase_core.dart';
import 'package:final_proj/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:final_proj/auth_cubit.dart';
import 'package:final_proj/auth_page.dart';
import 'package:final_proj/home_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart'; 
// Import the generated file
// Import the generated file
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
      ],
      child: const MyApp(),
    ),
  );
}

// Rest of your code remains unchanged...

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const SplashScreen(), // SplashScreen is the initial screen
      initialRoute: AuthPage.id,
      routes: {
        AuthPage.id: (context) =>  AuthPage(),
        HomePage.id: (context) => const HomePage(),
      },
    );
  }
}






/*
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
        BlocProvider<AdsCubit>(
          create: (context) => AdsCubit()..getAds(),
        ),
        BlocProvider<CategoriesCubit>(
          create: (context) => CategoriesCubit()..getCategories(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}
*/
