import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/task_service.dart';

class TaskDoneScreen extends StatelessWidget {
  const TaskDoneScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final taskServices = TaskServices();

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Bagian atas (judul)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFFA0D7C8), Color(0xFFA0C7D7)],
                  begin: Alignment.bottomLeft,
                  end: Alignment.topRight,
                ),
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
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Expanded(
                    child: Text(
                      'Done To Do',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48), // biar simetris sama IconButton kiri
                ],
              ),
            ),

            // List task
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: taskServices.getUserCompletedTasks(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(child: Text("Tidak ada task selesai"));
                    }

                    final tasks = snapshot.data!;

                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Card(
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
                              child: Icon(
                                task['category_icon'] ?? Icons.task,
                                size: 30,
                              ),
                            ),
                            title: Text(task['title'] ?? ''),
                            subtitle: Text(
                              "${task['due_date'] ?? ''}, ${task['due_time'] ?? ''}",
                            ),
                            trailing: const Checkbox(
                              value: true,
                              onChanged: null,
                            ),
                          ),
                        );
                      },
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
