import 'package:final_proj/Widgets/auth_page.dart';

import 'package:final_proj/cubits/store_cubit.dart';


import 'package:flutter/material.dart';

import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(
      const Duration(seconds: 9),
      () {
        context.read<StoreCubit>().fetchData();
        Navigator.pushReplacementNamed(context, AuthPage.id);
      },
    );
//
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/image.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: const Center(
          child: Text(
            'Welcome',
            style: TextStyle(
              fontSize: 30,
              color: Colors.pink,
            ),
          ),
        ),
      ),
    );
  }
}
