import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/Fire_auth/fire_auth_cubit.dart';

class AccountLayout extends StatelessWidget {
  const AccountLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Account"),
      ),
      body: Center(
        child: ElevatedButton.icon(
            onPressed: () {
              context.read<FireAuthRepo>().signOut(context);
            },
            icon: const Icon(Icons.logout),
            label: const Text("Log out")),
      ),
    );
  }
}
