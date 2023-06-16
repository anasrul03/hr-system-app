import 'package:flutter/material.dart';

class LeaveAppScreen extends StatefulWidget {
  const LeaveAppScreen({super.key});

  @override
  State<LeaveAppScreen> createState() => _LeaveAppScreenState();
}

class _LeaveAppScreenState extends State<LeaveAppScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Leave Application List"),
      ),
    );
  }
}
