import 'package:flutter/material.dart';
import 'package:projek2_aplikasi_todolist/screens/task_todo_screen.dart';
import 'package:projek2_aplikasi_todolist/screens/calender.dart';
import 'package:projek2_aplikasi_todolist/screens/create_task_screen.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: CreateTaskScreen(),
    );
  }
}