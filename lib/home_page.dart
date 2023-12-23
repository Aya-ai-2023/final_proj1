import 'package:final_proj/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:final_proj/auth_cubit.dart';

class HomePage extends StatelessWidget {
  static String id = 'home-page';

  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
        actions: [
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              // Sign out the user when the exit button is pressed
              context.read<AuthCubit>().signOut();
              // Navigate back to SplashScreen upon sign-out
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) =>  const SplashScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: const Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}

/*
class HomePage extends StatelessWidget {
  static String id = 'home-page';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              // Sign out the user when the exit button is pressed
              context.read<AuthCubit>().signOut();
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to the Home Page!'),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Define a cubit class to handle the authentication state
class AuthCubit extends Cubit<AuthState> {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final SharedPreferences _sharedPreferences = GetIt.I.get<SharedPreferences>();

  AuthCubit() : super(AuthInitial());

  // Sign up a user with email and password
  Future<void> signUp(String email, String password) async {
    try {
      emit(AuthLoading());
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message));
    }
  }

  // Sign in a user with email and password
  Future<void> signIn(String email, String password) async {
    try {
      emit(AuthLoading());
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message));
    }
  }

  // Sign out a user
  Future<void> signOut() async {
    try {
      emit(AuthLoading());
      await _firebaseAuth.signOut();
      emit(AuthInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message));
    }
  }

  // Send a password reset email to a user
  Future<void> resetPassword(String email) async {
    try {
      emit(AuthLoading());
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message));
    }
  }

  // Save the user's email in shared preferences
  Future<void> saveEmail(String email) async {
    await _sharedPreferences.setString('email', email);
  }

  // Get the user's email from shared preferences
  Future<String> getEmail() async {
    return _sharedPreferences.getString('email') ?? '';
  }
}

// Define the possible states for the cubit
abstract class AuthState {}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {}

class AuthFailure extends AuthState {
  final String message;

  AuthFailure(this.message);
}

// Define a widget to display the signup, signin and forgetpassword pages using tabBar
class AuthPage extends StatefulWidget {
  static String id = 'auth-page';

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Get the user's email from shared preferences and set it to the controller
    context.read<AuthCubit>().getEmail().then((value) {
      _emailController.text = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
        bottom: TabBar(
          tabs: [
            Tab(text: 'Sign Up'),
            Tab(text: 'Sign In'),
            Tab(text: 'Forget Password'),
          ],
        ),
      ),
      body: TabBarView(
        children: [
          SignUpPage(_emailController, _passwordController),
          SignInPage(_emailController, _passwordController),
          ForgetPasswordPage(_emailController),
        ],
      ),
    );
  }
}

// Define a widget to display the sign up page
class SignUpPage extends StatelessWidget {
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  SignUpPage(this._emailController, this._passwordController);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Show a success message and navigate to the home page
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Sign up successful'),
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
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          // Sign up the user with the email and password
                          context.read<AuthCubit>().signUp(
                                _emailController.text,
                                _passwordController.text,
                              );
                          // Save the email in shared preferences
                          context
                              .read<AuthCubit>()
                              .saveEmail(_emailController.text);
                        },
                  child: Text('Sign Up'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Define a widget to display the sign in page
class SignInPage extends StatelessWidget {
  final TextEditingController _emailController;
  final TextEditingController _passwordController;

  SignInPage(this._emailController, this._passwordController);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Show a success message and navigate to the home page
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
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
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
                SizedBox(height: 20),
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
                  child: Text('Sign In'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Define a widget to display the forget password page
class ForgetPasswordPage extends StatelessWidget {
  final TextEditingController _emailController;

  ForgetPasswordPage(this._emailController);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          // Show a success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Password reset email sent'),
              backgroundColor: Colors.green,
            ),
          );
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
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: state is AuthLoading
                      ? null
                      : () {
                          // Send a password reset email to the user
                          context
                              .read<AuthCubit>()
                              .resetPassword(_emailController.text);
                        },
                  child: Text('Send Email'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// Define a widget to display the home page
class HomePage extends StatelessWidget {
  static String id = 'home-page';

  @override
  Widget
*/