import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  // list kegiatan 
  static const List<TaskItem> tasks = [
    TaskItem(icon: Icons.cleaning_services, title: 'Do The Dishes', time: '5.00 AM'),
    TaskItem(icon: Icons.directions_run, title: 'Go Jogging', time: '6.00 AM'),
    TaskItem(icon: Icons.group, title: 'Meet With Friend', time: '1.00 PM'),
    TaskItem(icon: Icons.mosque, title: 'Pray', time: '2.45 PM'),
    TaskItem(icon: Icons.shopping_bag, title: 'Buy Skincare', time: '4.00 PM'),
  ];

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: const BoxDecoration(
                color: Color(0xFFFFE46A),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(28),
                ),
              ),
              child: const Column(  
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.arrow_back),
                  SizedBox(height: 12),
                  Text(
                    'To Do Day',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 4),
                  Text(
                    'July, 25, 2025',
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                ],
              ),
            ),

            // List tugas
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    return TaskCard(task: tasks[index]);
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

// Model data tugas
class TaskItem {
  final IconData icon;
  final String title;
  final String time;

  const TaskItem({required this.icon, required this.title, required this.time});
}

// Kartu tampilan tugas
class TaskCard extends StatelessWidget {
  final TaskItem task;

  const TaskCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: const Color(0xFFFFEB8C),
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: Offset(1, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: Colors.white,
          child: Icon(task.icon, color: Colors.black),
        ),
        title: Text(task.title, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(task.time),
        trailing: const Icon(Icons.check_box_outline_blank),
      ),
    );
  }
}
