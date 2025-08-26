import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:projek2_aplikasi_todolist/screens/task_done_screen.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';

class TaskTodoScreen extends StatefulWidget {
  const TaskTodoScreen({super.key});

  @override
  State<TaskTodoScreen> createState() => _TaskTodoScreenState();
}

class _TaskTodoScreenState extends State<TaskTodoScreen> {
  List<Map<String, dynamic>> tasks = [];

  final Map<String, IconData> categoryIcons = {
    'Religius': Icons.mosque,
    'Personal': Icons.person,
    'Healthy': Icons.directions_run,
    'Shopping': Icons.shopping_bag,
    'Work': Icons.work,
    'Other': Icons.category,
  };

  final Map<String, Color> priorityColors = {
    'High': const Color(0xFFE57373),
    'Mid': const Color(0xFFFFD54F),
    'Low': const Color(0xFF81C784),
  };

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

Future<void> _fetchTasks() async {
  final user = Supabase.instance.client.auth.currentUser;
  if (user == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Please login to view tasks')),
    );
    return;
  }

  try {
    // 🔹 Ambil tanggal hari ini dalam format YYYY-MM-DD (sesuai database)
    final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

    final response = await Supabase.instance.client
        .from('tasks')
        .select('''
          id, title, due_date, due_time, completed, notes,
          categories (name),
          priorities (name)
        ''')
        .eq('user_id', user.id)
        .eq('completed', false)
        .eq('due_date', today) // 🔥 filter by today
        .order('created_at', ascending: true);

    setState(() {
      tasks = response.map((task) {
        final categoryName = task['categories']['name'] ?? 'Other';
        final priorityName = task['priorities']['name'] ?? 'Low';
        final subtitle = _formatSubtitle(task['due_date'], task['due_time']);
        return {
          'id': task['id'],
          'icon': categoryIcons[categoryName] ?? Icons.category,
          'title': task['title'],
          'subtitle': subtitle,
          'done': task['completed'] ?? false,
          'priority': priorityName,
          'notes': task['notes'] ?? '',
          'category': categoryName,
        };
      }).toList();
    });
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Failed to load tasks: $e')),
    );
  }
}

  String _formatSubtitle(String? dueDate, String? dueTime) {
    if (dueDate == null) return '';
    final date = DateFormat('MMMM d, yyyy').format(DateTime.parse(dueDate));
    final time = dueTime ?? '';
    return '$date, $time';
  }

  Future<void> _updateTaskDone(String taskId, bool done) async {
    try {
      await Supabase.instance.client
          .from('tasks')
          .update({'completed': done})
          .eq('id', taskId);
      _fetchTasks();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update task: $e')),
      );
    }
  }

  Future<void> _deleteTask(String taskId) async {
    try {
      await Supabase.instance.client.from('tasks').delete().eq('id', taskId);
      _fetchTasks();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete task: $e')),
      );
    }
  }

  void showDeleteDialog(int index) {
    final taskId = tasks[index]['id'];
    AwesomeDialog(
      context: context,
      dialogType: DialogType.question,
      animType: AnimType.bottomSlide,
      title: "Confirm Delete Data",
      desc: "Are You Sure You Want To Delete Data?",
      showCloseIcon: true,
      btnOkOnPress: () {
        _deleteTask(taskId);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text("Data Sudah Terhapus"),
            backgroundColor: Color(0xFF15FF00),
            duration: Duration(seconds: 2),
          ),
        );
      },
      btnCancelOnPress: () {},
    ).show();
  }

  void showTaskDetailDialog(Map<String, dynamic> task) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      barrierColor: Colors.black54,
      transitionDuration: const Duration(milliseconds: 300),
      pageBuilder: (context, anim1, anim2) {
        return Center(
          child: Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
            backgroundColor: priorityColors[task['priority']] ?? const Color(0xFFA0D7C8),
            elevation: 10,
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.1),
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(
                          task['icon'] ?? Icons.category_outlined,
                          color: Colors.white,
                          size: 30,
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            task['title'] ?? 'Tidak ada judul',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      const Icon(Icons.priority_high, size: 20, color: Colors.white),
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
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20, color: Colors.white),
                      const SizedBox(width: 8),
                      Text(
                        task['subtitle'] != null && task['subtitle'].isNotEmpty
                            ? task['subtitle']
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
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.notes, size: 20, color: Colors.white),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          task['notes'] != null && task['notes'].toString().trim().isNotEmpty
                              ? task['notes'].toString()
                              : 'Tidak ada catatan.',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        foregroundColor: Colors.teal,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                      onPressed: () => Navigator.pop(context),
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
      transitionBuilder: (context, anim1, anim2, child) {
        return Transform.scale(
          scale: Curves.easeInOut.transform(anim1.value),
          child: child,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final currentDate = DateFormat('MMMM, d, yyyy').format(DateTime.now());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
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
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back_ios_new_rounded),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'To Do List',
                          style: GoogleFonts.poppins(
                            fontSize: 32,
                            fontWeight: FontWeight.w700,
                            color: const Color(0xFF584A4A),
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          currentDate,
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: tasks.isEmpty
                    ? const Center(child: Text('No tasks found'))
                    : ListView.builder(
                        itemCount: tasks.length,
                        itemBuilder: (context, index) {
                          final task = tasks[index];
                          return Column(
                            children: [
                              Slidable(
                                key: ValueKey(task['id']),
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
                                  color: priorityColors[task['priority']] ?? const Color(0xFFA0D7C8),
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
                                        final newValue = value ?? false;
                                        final taskId = tasks[index]['id'];
                                        _updateTaskDone(taskId, newValue);
                                        if (newValue) {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => const TaskDoneScreen(),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                    onTap: () => showTaskDetailDialog(task),
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