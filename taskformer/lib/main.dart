import 'package:flutter/material.dart';
import 'package:taskformer/screens/login_screen.dart';

void main() {
  runApp(const PastPortApp());
}

class PastPortApp extends StatelessWidget {
  const PastPortApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.black,
      ),
      home: const LoginScreen(), // Start with the LoginScreen
    );
  }
}
