import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import '../services/task_service.dart';
import '../services/auth_services.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  late DateTime _selectedDate;
  late List<DateTime> _weekDates;

  final Map<String, IconData> categoryIcons = {
    'Religius': Icons.mosque,
    'Personal': Icons.person,
    'Healthy': Icons.directions_run,
    'Shopping': Icons.shopping_bag,
    'Work': Icons.work,
    'Other': Icons.category,
  };

  @override
  void initState() {
    super.initState();
    _selectedDate = DateTime.now();
    _updateWeekDates();
  }

  void _updateWeekDates() {
    final now = DateTime.now();
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    _weekDates =
        List.generate(7, (index) => startOfWeek.add(Duration(days: index)));
  }

  String _formatDate(DateTime date) {
    return DateFormat('d').format(date);
  }

  String _formatHeaderDate(DateTime date) {
    return DateFormat('MMMM, d yyyy').format(date);
  }

  String _formatSupabaseDate(DateTime date) {
    return DateFormat('yyyy-MM-dd').format(date);
  }

  void showTaskDetailDialog(Map<String, dynamic> task) {
    final taskServices = TaskServices();
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
            backgroundColor: taskServices.priorityColors[task['priority']] ?? const Color(0xFFA0D7C8),
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
                          task['category_icon'] ?? Icons.category_outlined,
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
                      const Icon(Icons.priority_high, size: 20, color: Colors.white70),
                      const SizedBox(width: 8),
                      Text(
                        'Prioritas: ${task['priority'] ?? 'Tidak ada prioritas'}',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    children: [
                      const Icon(Icons.calendar_today, size: 20, color: Colors.white70),
                      const SizedBox(width: 8),
                      Text(
                        task['due_date'] != null && task['due_date'].isNotEmpty
                            ? "${task['due_date']} ${task['due_time'] ?? ''}"
                            : 'Tidak terjadwal',
                        style: GoogleFonts.poppins(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Icon(Icons.notes, size: 20, color: Colors.white70),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          task['notes'] != null && task['notes'].toString().trim().isNotEmpty
                              ? task['notes'].toString()
                              : 'Tidak ada catatan.',
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                            fontWeight: FontWeight.w400,
                            color: Colors.white70,
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
    final taskServices = TaskServices();
    final authServices = AuthServices();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Today',
          style: GoogleFonts.poppins(
            fontSize: 24,
            color: const Color(0xFF584A4A),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 24,
            color: Color(0xFF584A4A),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FutureBuilder(
            future: authServices.getUserProfile(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: CircularProgressIndicator(),
                );
              }

              if (snapshot.hasError) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text("Error: ${snapshot.error}"),
                );
              }

              final profile = snapshot.data ?? {};

              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      'Productive Day, ${profile['name'] ?? 'User'}',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF584A4A),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      _formatHeaderDate(_selectedDate),
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: const Color(0xFF584A4A),
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 30),
          Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final date = _weekDates[index];
                final isSelected = date.day == _selectedDate.day &&
                    date.month == _selectedDate.month &&
                    date.year == _selectedDate.year;
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: isSelected
                        ? const Color(0xFFA0D7C8)
                        : Colors.transparent,
                    radius: 18.0,
                    child: Text(
                      _formatDate(date),
                      style: GoogleFonts.poppins(
                        fontWeight:
                            isSelected ? FontWeight.bold : FontWeight.normal,
                        color:
                            isSelected ? const Color(0xFF584A4A) : Colors.grey,
                        fontSize: 14,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                );
              }),
            ),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: taskServices
                  .getTasksByDate(_formatSupabaseDate(_selectedDate)),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                final tasks = snapshot.data ?? [];
                if (tasks.isEmpty) {
                  return Center(
                    child: Text(
                      'No tasks for this date',
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        color: const Color(0xFF584A4A),
                      ),
                    ),
                  );
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    final priorityName = (task['priority'] ?? 'Low') as String;
                    final categoryName = (task['categories']?['name'] ?? 'Other') as String;
                    return GestureDetector(
                      onTap: () => showTaskDetailDialog({
                        ...task,
                        'category_icon': categoryIcons[categoryName] ?? Icons.category,
                        'priority': priorityName,
                        'due_date': task['due_date'] ?? '',
                        'due_time': task['due_time'] ?? '',
                        'notes': task['notes'] ?? '',
                      }),
                      child: Container(
                        width: 368,
                        height: 71,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 10),
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: taskServices.priorityColors[priorityName] ??
                              const Color(0xFFA0D7C8),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            Text(
                              task['due_time'].isNotEmpty
                                  ? task['due_time']
                                  : 'All day',
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                                color: const Color(0xFF584A4A),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Text(
                                task['title'],
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 16,
                                  color: const Color(0xFF584A4A),
                                ),
                              ),
                            ),
                            Icon(
                              categoryIcons[categoryName] ?? Icons.category,
                              color: const Color(0xFF584A4A),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}