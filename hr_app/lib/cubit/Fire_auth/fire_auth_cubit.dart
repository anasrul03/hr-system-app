// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_interpolation_to_compose_strings, avoid_print, unnecessary_brace_in_string_interps

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hr_app/view/Login.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import 'fire_auth_state.dart';

class FireAuthRepo extends Cubit<FireAuthState> {
  FireAuthRepo() : super(FireAuthState.initial()) {
    checkSignin();
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  void emailChanged(String value) {
    emit(state.copyWith(email: value, status: FireAuthStatus.initial));
  }

  void passwordChanged(String value) {
    emit(state.copyWith(password: value, status: FireAuthStatus.initial));
  }

  Future checkSignin() async {
    final User? user = _auth.currentUser;

    if (user != null) {
      emit(state.copyWith(user: user));
    }
  }

  Future signUp(BuildContext context, String email, String password) async {
    print("Running Firebase Create user");
    try {
      final createUser = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      Fluttertoast.showToast(
          msg: "Successfully Registered! as ${email}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          // backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } on FirebaseAuthException catch (e) {
      print("Error : $e");

      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }

      Fluttertoast.showToast(
          msg: "Firebase Error!: $e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          // backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print("Error : $e");
      Fluttertoast.showToast(
          msg: "Error Catch! >> $e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          // backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future logIn(BuildContext context, bool loaded) async {
    try {
      var user = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: state.email,
        password: state.password,
      );
      emit(state.copyWith(user: user.user));
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      // Try reading data from the 'action' key. If it doesn't exist, returns null.
      prefs.setString('email', state.email!);
      print(user);
      Fluttertoast.showToast(
          msg: "Successfully Logged as ${state.email}",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          // backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      print("ERROR: $e");
      Fluttertoast.showToast(
          msg: "Please input a correct email and password !!",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          // backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
    loaded = false;
    SchedulerBinding.instance.addPostFrameCallback((_) {
      navigatorKey.currentState!.popUntil((route) => route.isFirst);
    });
  }

  Future signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(state.copyWith(
          email: "", password: "", status: FireAuthStatus.initial));
      Fluttertoast.showToast(
          msg: "Logged out",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          // backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: "Error Catch! >> $e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          // backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } catch (e) {
      Fluttertoast.showToast(
          msg: "Error Catch! >> $e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          // backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }
}
