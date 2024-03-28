import 'package:flutter/material.dart';

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        flexibleSpace: Center(
          child: Text(
            "Register",
            style: TextStyle(
              fontFamily: 'atma',
              fontSize: 33,
              color: Color(0xFFFF6B00),
            ),
          ),
        ),
      ),
    );
  }
}