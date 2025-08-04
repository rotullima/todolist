import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:projek2_aplikasi_todolist/screens/task_done_screen.dart';

class TaskTodoScreen extends StatefulWidget {
  const TaskTodoScreen({super.key});

  @override
  State<TaskTodoScreen> createState() => _TaskTodoScreenState();
}

class _TaskTodoScreenState extends State<TaskTodoScreen> {
  bool fungsiCheckBox = false;

  // Data list task
  List<Map<String, dynamic>> tasks = [
    {
      'icon': Icons.cleaning_services, //Icon Kegiatan
      'title': 'Do The Dishes', //Judul tugasa
      'subtitle': '23 Juli 2025, 19:00', //Waktu Tugas
      'done': false, //Status Checklist
    },
    {
      'icon': Icons.directions_run,
      'title': 'Jogging',
      'subtitle': '23 Juli 2025, 05:00',
      'done': false,
    },
    {
      'icon': Icons.group,
      'title': 'Bermain bersama teman',
      'subtitle': '23 Juli 2025, 19:00',
      'done': false,
    },
    {
      'icon': Icons.mosque,
      'title': "Sholawat Rutin Habis Isya'",
      'subtitle': '24 Juli 2025, 20:00',
      'done': false,
    },
    {
      'icon': Icons.shopping_bag,
      'title': 'Beli Skincare di Sociolla',
      'subtitle': '25 Juli 2025, 10:00',
      'done': false,
    },
  ];

  void showDeleteDialog(int index) {
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question, 
      animType: AnimType.bottomSlide, 
      title: "Confirm Delete Data", 
      desc: "Are You Sure You Want To Delete Data?", 
      showCloseIcon: true, 
      btnOkOnPress: () {
        setState(() {
          tasks.removeAt(index); 
        });
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Data Sudah Terhapus"), 
            backgroundColor: Color(0xFF15FF00),
            duration: Duration(seconds: 2), 
          ),
        );
      },
      btnCancelOnPress: () {}, 
    ).show(); 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Header
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFA0D7C8), Color(0xFFA0C7D7)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
                color: Color(0xFFA0D7C8),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'To Do Day',
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF584A4A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'July, 25, 2025',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xFF584A4A),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24),
                ],
              ),
            ),

            // Task List
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return Column(
                      children: [
                        Slidable(
                          key: ValueKey(index),
                          endActionPane: ActionPane(
                            motion: const DrawerMotion(),
                            children: [
                              SlidableAction(
                                onPressed: (_) => showDeleteDialog(index),
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white,
                                icon: Icons.delete,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: Card(
                            color: const Color(0xFFA0D7C8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: ListTile(
                              leading: Container(
                                width: 50,
                                height: 50,
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: Icon(task['icon'], size: 30),
                              ),
                              title: Text(
                                task['title'],
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF584A4A),
                                ),
                              ),
                              subtitle: Text(task['subtitle']),
                              trailing: Checkbox(
                                value: task['done'],
                                onChanged: (bool? value) {
                                  setState(() {
                                    tasks[index]['done'] = value ?? false;
                                  });
                                  if (value == true) {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const TaskDoneScreen(),
                                      ),
                                    );
                                  }
                                },
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
