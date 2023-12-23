import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:final_proj/aut_states.dart';


class AuthCubit extends Cubit<AuthState> {
//  
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final SharedPreferences _sharedPreferences;

  AuthCubit(this._sharedPreferences) : super(AuthInitial());

  // Sign up a user with email and password
  Future<void> signUp( String email,  String password) async {
    try {
      emit(AuthLoading());
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message??'no'));
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
      emit(AuthFailure(e.message??'no'));
    }
  }

  // Sign out a user
  Future<void> signOut() async {
    try {
      emit(AuthLoading());
      await _firebaseAuth.signOut();
      emit(AuthInitial());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message??'no'));
    }
  }

  // Send a password reset email to a user
  Future<void> resetPassword(String email) async {
    try {
      emit(AuthLoading());
      await _firebaseAuth.sendPasswordResetEmail(email: email);
      emit(AuthSuccess());
    } on FirebaseAuthException catch (e) {
      emit(AuthFailure(e.message??'no'));
    }
  }

  // Save the user's email in shared preferences
  Future<void> saveEmail(String email) async {
    await _sharedPreferences.setString('email', email);
  }

  // Get the user's email from shared preferences
  Future<String> getEmail() async {
    return _sharedPreferences.getString('email') ?? 'no';
  }}
