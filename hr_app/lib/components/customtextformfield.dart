import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String hintText;
  final Icon icon;
  final Function(String) onchanged;
  const CustomTextField({
    super.key,
    required this.hintText,
    required this.icon,
    required this.onchanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        onChanged: onchanged,
        decoration: InputDecoration(
            prefixIcon: icon,
            // border: OutlineInputBorder(),
            hintText: hintText),
      ),
    );
  }
}

class PasswordField extends StatelessWidget {
  final Function() onpress;
  final Function(String) onchanged;
  final String hintText;
  const PasswordField({
    super.key,
    required bool obscurePassword,
    required this.onpress,
    required this.onchanged,
    required this.hintText,
  }) : _obscurePassword = obscurePassword;

  final bool _obscurePassword;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 10, 20, 10),
      child: TextFormField(
        onChanged: onchanged,
        obscureText: _obscurePassword,
        decoration: InputDecoration(
            prefixIcon: const Icon(Icons.password),
            suffixIcon: IconButton(
                onPressed: onpress,
                icon: Icon(_obscurePassword
                    ? Icons.visibility
                    : Icons.visibility_off)),
            // border: OutlineInputBorder(),
            hintText: hintText),
      ),
    );
  }
}
