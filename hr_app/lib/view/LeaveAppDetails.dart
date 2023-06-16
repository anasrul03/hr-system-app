import 'package:flutter/material.dart';

class LeaveDetailScreen extends StatefulWidget {
  const LeaveDetailScreen({super.key});

  @override
  State<LeaveDetailScreen> createState() => _LeaveDetailScreenState();
}

class _LeaveDetailScreenState extends State<LeaveDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Leave Detail"),
      ),
    );
  }
}
