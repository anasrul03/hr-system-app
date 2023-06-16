import 'package:flutter/material.dart';

class PayrollDetailScreen extends StatefulWidget {
  const PayrollDetailScreen({super.key});

  @override
  State<PayrollDetailScreen> createState() => _PayrollDetailScreenState();
}

class _PayrollDetailScreenState extends State<PayrollDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Text("Payroll Details"),
      ),
    );
  }
}
