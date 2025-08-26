import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../services/task_service.dart';

class TaskDoneScreen extends StatefulWidget {
  const TaskDoneScreen({super.key});

  @override
  State<TaskDoneScreen> createState() => _TaskDoneScreenState();
}

class _TaskDoneScreenState extends State<TaskDoneScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final taskServices = TaskServices();

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
                    icon: const Icon(Icons.arrow_back_ios_new_rounded,
                        color: Colors.white),
                  ),
                  Expanded(
                    child: Text(
                      'To Do Done',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(width: 48),
                ],
              ),
            ),

            // List task
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: FutureBuilder<List<Map<String, dynamic>>>(
                  future: taskServices.getUserCompletedTasksByDate(
                    selectedDate
                        .toIso8601String()
                        .split('T')[0], // format YYYY-MM-DD
                  ),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    if (snapshot.hasError) {
                      return Center(child: Text("Error: ${snapshot.error}"));
                    }
                    if (!snapshot.hasData || snapshot.data!.isEmpty) {
                      return const Center(
                          child: Text("No completed task"));
                    }

                    final tasks = snapshot.data!;

                    return ListView.builder(
                      itemCount: tasks.length,
                      itemBuilder: (context, index) {
                        final task = tasks[index];
                        return Card(
                          color:
                              taskServices.priorityColors[task['priority']] ??
                                  const Color(0xFFA0D7C8),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 4,
                          margin: const EdgeInsets.symmetric(vertical: 10),
                          child: ListTile(
                            contentPadding: const EdgeInsets.all(12),
                            leading: CircleAvatar(
                              radius: 26,
                              backgroundColor: Colors.white,
                              child: Icon(
                                task['category_icon'] ?? Icons.task,
                                size: 28,
                                color: Colors.black87,
                              ),
                            ),
                            title: Text(
                              task['title'] ?? '',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            subtitle: Text(
                              "${task['due_date'] ?? ''}, ${task['due_time'] ?? ''}",
                              style: GoogleFonts.poppins(fontSize: 13),
                            ),
                            trailing: const Icon(
                              Icons.check_circle,
                              color: Colors.white,
                              size: 28,
                            ),
                            onTap: () {
                              showGeneralDialog(
                                context: context,
                                barrierDismissible: true,
                                barrierLabel: MaterialLocalizations.of(context)
                                    .modalBarrierDismissLabel,
                                barrierColor: Colors.black54,
                                transitionDuration:
                                    const Duration(milliseconds: 300),
                                pageBuilder: (context, anim1, anim2) {
                                  return Center(
                                    child: Dialog(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      backgroundColor:
                                          taskServices.priorityColors[
                                                  task['priority']] ??
                                              const Color(0xFFA0D7C8),
                                      elevation: 10,
                                      child: Padding(
                                        padding: const EdgeInsets.all(20),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            // Header Dialog
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10,
                                                      horizontal: 15),
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.1),
                                                borderRadius:
                                                    const BorderRadius.only(
                                                  topLeft: Radius.circular(15),
                                                  topRight: Radius.circular(15),
                                                ),
                                              ),
                                              child: Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: [
                                                  Icon(
                                                    task['category_icon'] ??
                                                        Icons.category_outlined,
                                                    color: Colors.white,
                                                    size: 30,
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Expanded(
                                                    child: Text(
                                                      task['title'] ??
                                                          'Tidak ada judul',
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 20,
                                                        fontWeight:
                                                            FontWeight.w700,
                                                        color: Colors.white,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            const SizedBox(height: 20),

                                            // Prioritas
                                            Row(
                                              children: [
                                                const Icon(Icons.priority_high,
                                                    size: 20,
                                                    color: Colors.white),
                                                const SizedBox(width: 8),
                                                Text(
                                                  'Prioritas: ${task['priority'] ?? 'Tidak ada prioritas'}',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),

                                            // Tanggal & waktu
                                            Row(
                                              children: [
                                                const Icon(Icons.calendar_today,
                                                    size: 20,
                                                    color: Colors.white),
                                                const SizedBox(width: 8),
                                                Text(
                                                  task['due_date'] != null
                                                      ? "${task['due_date']} ${task['due_time'] ?? ''}"
                                                      : 'Tidak terjadwal',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 15),

                                            // Catatan
                                            Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Icon(Icons.notes,
                                                    size: 20,
                                                    color: Colors.white),
                                                const SizedBox(width: 8),
                                                Expanded(
                                                  child: Text(
                                                    task['notes'] != null &&
                                                            task['notes']
                                                                .toString()
                                                                .trim()
                                                                .isNotEmpty
                                                        ? task['notes']
                                                            .toString()
                                                        : 'Tidak ada catatan.',
                                                    style: GoogleFonts.poppins(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 20),

                                            // Tombol Tutup
                                            Align(
                                              alignment: Alignment.centerRight,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.white,
                                                  foregroundColor: Colors.teal,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            12),
                                                  ),
                                                  elevation: 2,
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 10),
                                                ),
                                                onPressed: () =>
                                                    Navigator.pop(context),
                                                child: Text(
                                                  'Tutup',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w600,
                                                    color: Colors.teal,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                transitionBuilder:
                                    (context, anim1, anim2, child) {
                                  return Transform.scale(
                                    scale:
                                        Curves.easeInOut.transform(anim1.value),
                                    child: child,
                                  );
                                },
                              );
                            },
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
