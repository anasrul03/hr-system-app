import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hive_flutter/adapters.dart';
import 'package:hr_app/view/Home.dart';
import 'package:hr_app/view/Register.dart';

import '../components/customtextformfield.dart';
import '../cubit/Fire_auth/fire_auth_cubit.dart';
import '../cubit/Fire_auth/fire_auth_state.dart';

class LoginLayout extends StatefulWidget {
  VoidCallback? toSignUpPage;
  LoginLayout({super.key, this.toSignUpPage});

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  final bool isLoading = false;
  bool _obscurePassword = true;
  final TextStyle title = const TextStyle(
      fontWeight: FontWeight.bold, fontSize: 60, color: Colors.black);
  @override
  void initState() {
    super.initState();
    _obscurePassword = true;
    FireAuthRepo().checkSignin();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<FireAuthRepo, FireAuthState>(
      builder: (context, state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          // backgroundColor: Colors.indigo,
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Welcome Back",
                  style: title,
                ),
                CustomTextField(
                  icon: const Icon(Icons.email),
                  hintText: 'Email',
                  onchanged: (value) {
                    context.read<FireAuthRepo>().emailChanged(value);
                    print(state.password);
                  },
                ),
                PasswordField(
                  obscurePassword: _obscurePassword,
                  hintText: 'Password',
                  onpress: () {
                    setState(() {
                      _obscurePassword = !_obscurePassword;
                    });
                  },
                  onchanged: (value) {
                    context.read<FireAuthRepo>().passwordChanged(value);
                    print(state.password);
                  },
                ),
                ElevatedButton.icon(
                    style: ButtonStyle(
                      fixedSize: MaterialStateProperty.all(const Size(200, 40)),
                    ),
                    onPressed: () {
                      context.read<FireAuthRepo>().showLoaderDialog(context);
                      context.read<FireAuthRepo>().logIn(context, isLoading);
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.login),
                    label: const Text("Login"))
              ],
            ),
          ),
        );
      },
    );
  }
}
