import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:intl/intl.dart';
import 'package:todolist/screens/task_done_screen.dart'; // Asumsikan ini sudah ada

class TaskTodoScreen extends StatefulWidget {
  const TaskTodoScreen({super.key});

  @override
  State<TaskTodoScreen> createState() => _TaskTodoScreenState();
}

class _TaskTodoScreenState extends State<TaskTodoScreen> {
  // List tasks akan diisi dari Supabase
  List<Map<String, dynamic>> tasks = [];

  // Mapping icon berdasarkan category name (sesuaikan dengan categories di DB)
  final Map<String, IconData> categoryIcons = {
    'Religius': Icons.mosque,
    'Personal': Icons.person,
    'Healthy': Icons.directions_run,
    'Shopping': Icons.shopping_bag,
    'Work': Icons.work,
    'Other': Icons.category,
  };

  final Map<String, Color> priorityColors = {
  'High': const Color(0xFFE57373),   // merah soft
  'Mid': const Color(0xFFFFD54F), // kuning soft
  'Low': const Color(0xFF81C784),    // hijau soft
  };

  @override
  void initState() {
    super.initState();
    _fetchTasks();
  }

  // Fetch tasks dari Supabase, hanya yang belum completed dan milik user login
  Future<void> _fetchTasks() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please login to view tasks')),
      );
      return;
    }

    try {
      final response = await Supabase.instance.client
          .from('tasks')
          .select('''
            id, title, due_date, due_time, completed, notes,
            categories (name),
            priorities (name)
          ''')
          .eq('user_id', user.id)
          .eq('completed', false) // Hanya tampilkan yang belum done
          .order('created_at', ascending: true);

      setState(() {
        tasks = response.map((task) {
          final categoryName = task['categories']['name'] ?? 'Other';
          final priorityName = task['priorities']['name'] ?? 'Low';
          final subtitle = _formatSubtitle(task['due_date'], task['due_time']);
          return {
            'id': task['id'], // Simpan ID untuk update/delete
            'icon': categoryIcons[categoryName] ?? Icons.category,
            'title': task['title'],
            'subtitle': subtitle,
            'done': task['completed'] ?? false,
            'priority': priorityName,
          };
        }).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load tasks: $e')),
      );
    }
  }

  // Format subtitle dari due_date dan due_time
  String _formatSubtitle(String? dueDate, String? dueTime) {
    if (dueDate == null) return '';
    final date = DateFormat('MMMM d, yyyy').format(DateTime.parse(dueDate));
    final time = dueTime ?? '';
    return '$date, $time';
  }

  // Update status completed di Supabase
  Future<void> _updateTaskDone(String taskId, bool done) async {
    try {
      await Supabase.instance.client
          .from('tasks')
          .update({'completed': done})
          .eq('id', taskId);
      // Refresh list setelah update
      _fetchTasks();
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to update task: $e')),
      );
    }
  }

  // Hapus task dari Supabase
  Future<void> _deleteTask(String taskId) async {
    try {
      await Supabase.instance.client.from('tasks').delete().eq('id', taskId);
      // Refresh list setelah delete
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

  @override
  Widget build(BuildContext context) {
    // Tanggal hari ini secara dinamis
    final currentDate = DateFormat('MMMM, d, yyyy').format(DateTime.now());

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
                          currentDate, // Ganti ke tanggal dinamis
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