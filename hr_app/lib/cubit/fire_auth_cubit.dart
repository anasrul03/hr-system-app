// ignore_for_file: prefer_const_constructors, use_build_context_synchronously, prefer_interpolation_to_compose_strings, avoid_print, unnecessary_brace_in_string_interps

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:hr_app/cubit/fire_auth_state.dart';
import '../main.dart';

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

  Future<void> checkSignin() async {
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
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  Future signOut(BuildContext context) async {
    try {
      GoogleSignIn().disconnect();
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

  Future anon(context) async {
    try {
      var user = await FirebaseAuth.instance.signInAnonymously();
      Fluttertoast.showToast(
          msg: "Sign in as Anon",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          // backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(state.copyWith(user: user.user));
    } catch (e) {
      print("ERROR: $e");
      Fluttertoast.showToast(
          msg: "Cannot Log! Anon : $e",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          // backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content: Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
