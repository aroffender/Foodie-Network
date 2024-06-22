import 'package:flutter/material.dart';
class AuthtenticationScreen extends StatefulWidget {
  const AuthtenticationScreen({super.key});

  @override
  State<AuthtenticationScreen> createState() => _AuthtenticationScreenState();
}

class _AuthtenticationScreenState extends State<AuthtenticationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
    );
  }
}
