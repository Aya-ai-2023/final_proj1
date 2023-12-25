import 'package:final_proj/Widgets/forget_password_page.dart';
import 'package:final_proj/Widgets/sign_in_page.dart';
import 'package:final_proj/Widgets/sign_up_page.dart';
import 'package:flutter/material.dart';



class AuthPage extends StatelessWidget {
  AuthPage({super.key});
  static String id = 'auth-page';
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter App'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Sign Up'),
              Tab(text: 'Sign In'),
              Tab(text: 'Forget Password'),
            ],
          ),
        ),
        body: Container(
          decoration: BoxDecoration(
            color: Colors.grey[100],
          ),
          child: TabBarView(
            children: [
              SignUpPage(_emailController, _passwordController),
              SignInPage(_emailController, _passwordController),
              ForgetPasswordPage(_emailController),
            ],
          ),
        ),
      ),
    );
  }
}
