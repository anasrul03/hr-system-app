import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/Fire_auth/fire_auth_cubit.dart';

class LeaveAppScreen extends StatefulWidget {
  const LeaveAppScreen({super.key});

  @override
  State<LeaveAppScreen> createState() => _LeaveAppScreenState();
}

class _LeaveAppScreenState extends State<LeaveAppScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
