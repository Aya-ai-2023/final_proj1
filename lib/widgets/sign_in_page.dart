import 'package:final_proj/cubits/aut_states.dart';
import 'package:final_proj/cubits/auth_cubit.dart';
import 'package:final_proj/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';




class SignInPage extends StatelessWidget {
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  const SignInPage(this._emailController, this._passwordController, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Show a success message and navigate to the home page
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Sign in successful'),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushNamed(context, HomePage.id);
        } else if (state is AuthFailure) {
          // Show an error message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          // Sign in the user with the email and password
                          context.read<AuthCubit>().signIn(
                                _emailController.text,
                                _passwordController.text,
                              );
                          // Save the email in shared preferences
                          context
                              .read<AuthCubit>()
                              .saveEmail(_emailController.text);
                        },
                  child: const Text('Sign In'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
