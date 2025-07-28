import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:projek2_aplikasi_todolist/screens/task_done_screen.dart';

class TaskTodoScreen extends StatefulWidget {
  const TaskTodoScreen({super.key});

  @override
  State<TaskTodoScreen> createState() => _TaskTodoScreenState();
}

class _TaskTodoScreenState extends State<TaskTodoScreen> {
  bool fungsiCheckBox = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Bagian atas (judul + tanggal)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: const BoxDecoration(
                color: Color(0xFFA0D7C8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(Icons.arrow_back_ios_new_rounded)),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'To Do Day',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'July, 25, 2025',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),

            // const SizedBox(height: 20),

            // List tugas harian
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: ListView(
                  children: [
                    Card(
                      color: Color(0xFFA0D7C8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Icon(
                            Icons.cleaning_services,
                            size: 30,
                          ),
                        ),
                        title: Text('Mencuci piring'),
                        subtitle: Text('23 Juli 2025, 19:00'),
                        trailing: Checkbox(
                          value: fungsiCheckBox,
                          onChanged: (bool? value) {
                            setState(() {
                              fungsiCheckBox = value ?? false;
                            });
                            if (value == true) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const TaskDoneScreen(),
                                ),
                              );
                            }
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      color: Color(0xFFA0D7C8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Icon(
                            Icons.directions_run,
                            size: 30,
                          ),
                        ),
                        title: Text('Jogging'),
                        subtitle: Text('23 Juli 2025, 05:00'),
                        trailing: Checkbox(
                          value: false,
                          onChanged: null,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      color: Color(0xFFA0D7C8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Icon(
                            Icons.group,
                            size: 30,
                          ),
                        ),
                        title: Text('Bermain bersama teman'),
                        subtitle: Text('23 Juli 2025, 19:00'),
                        trailing: Checkbox(
                          value: false,
                          onChanged: null,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      color: Color(0xFFA0D7C8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Icon(
                            Icons.mosque,
                            size: 30,
                          ),
                        ),
                        title: Text("Sholawat Rutin Habis Isya'"),
                        subtitle: Text('24 Juli 2025, 20:00'),
                        trailing: Checkbox(value: false, onChanged: null),
                      ),
                    ),
                    SizedBox(height: 10),
                    Card(
                      color: Color(0xFFA0D7C8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                              shape: BoxShape.circle, color: Colors.white),
                          child: Icon(
                            Icons.shopping_bag,
                            size: 30,
                          ),
                        ),
                        title: Text('Beli Skincare di Sociolla'),
                        subtitle: Text('25 Juli 2025, 10:00'),
                        trailing: Checkbox(value: false, onChanged: null),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
