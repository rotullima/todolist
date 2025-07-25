import 'package:flutter/material.dart';
import 'package:projek2_aplikasi_todolist/screens/home_screen.dart';
import 'package:projek2_aplikasi_todolist/screens/splash_screen.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}