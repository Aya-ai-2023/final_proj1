

// Define a widget to display the signup, signin and forgetpassword pages using tabBar
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:final_proj/auth_cubit.dart';
import 'package:final_proj/forget_password_page.dart';
import 'package:final_proj/sign_in_page.dart';
import 'package:final_proj/sign_up_page.dart';

// class AuthPage extends StatefulWidget {
//   static String id = 'auth-page';

//   const AuthPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _AuthPageState createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Get the user's email from shared preferences and set it to the controller
//     context.read<AuthCubit>().getEmail().then((value) {
//       _emailController.text = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Flutter App'),
//         bottom: const TabBar(
//           tabs: [
//             Tab(text: 'Sign Up'),
//             Tab(text: 'Sign In'),
//             Tab(text: 'Forget Password'),
//           ],
//         ),
//       ),
//       body: TabBarView(
//         children: [
//           SignUpPage(_emailController, _passwordController),
//           SignInPage(_emailController, _passwordController),
//           ForgetPasswordPage(_emailController),
//         ],
//       ),
//     );
//   }
// }
// class AuthPage extends StatefulWidget {
//   static String id = 'auth-page';

//   const AuthPage({super.key});

//   @override
//   // ignore: library_private_types_in_public_api
//   _AuthPageState createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     // Get the user's email from shared preferences and set it to the controller
//     context.read<AuthCubit>().getEmail().then((value) {
//       _emailController.text = value;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return DefaultTabController(
//       length: 3,
//       child: Scaffold(
//         appBar: AppBar(
//           title: const Text('Flutter App'),
//           bottom: const TabBar(
//             tabs: [
//               Tab(text: 'Sign Up'),
//               Tab(text: 'Sign In'),
//               Tab(text: 'Forget Password'),
//             ],
//           ),
//         ),
//         body: TabBarView(
//           children: [
//             SignUpPage(_emailController, _passwordController),
//             SignInPage(_emailController, _passwordController),
//             ForgetPasswordPage(_emailController),
//           ],
//         ),
//       ),
//     );
//   }
// }





// SplashScreen with background image


// AuthPage with background image
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
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/image.jpg'), // Replace with your image path
              fit: BoxFit.cover,
            ),
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
//C:\Users\aya\StudioProjects\final_proj\assets\images