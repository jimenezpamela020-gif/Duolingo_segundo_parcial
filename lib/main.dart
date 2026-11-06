import 'package:flutter/material.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(const DuolingoApp());
}

class DuolingoApp extends StatelessWidget {
  const DuolingoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Duolingo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(useMaterial3: true),
      home: const LoginScreen(),
    );
  }
}
