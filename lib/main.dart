import 'package:flutter/material.dart';
import 'package:projek2_aplikasi_todolist/screens/splash_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
void main() async {
  await Supabase.initialize(
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImN1eG9ieHd3a3NteHd2aXVvdXJvIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTQ5MjgwOTMsImV4cCI6MjA3MDUwNDA5M30.0xSqXHGSkvMUef-yEqqL38c6Xk5zDwvKNI17zrmC4sA',
    url: 'https://cuxobxwwksmxwviuouro.supabase.co'
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}