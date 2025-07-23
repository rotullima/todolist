import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 28),
              decoration: const BoxDecoration(
                color: Color(0xFFFFE46A),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(25),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.arrow_back),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: const [
                        Text(
                          'To Do Day',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          'July, 25, 2025',
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black54,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 24), // Sebagai penyeimbang dari Icon kiri
                ],
              ),
            ),

            const SizedBox(height: 20),

            // List tugas harian
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: ListView(
                  children: [
                    Card(
                      color: Color(0xFFFFE46A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.cleaning_services),
                        title: const Text('Mencuci piring'),
                        subtitle: const Text('23 Juli 2025, 19:00'),
                        trailing: Checkbox(
                          value: false,
                          onChanged: null,
                        ),
                      ),
                    ),
                    Card(
                      color: Color(0xFFFFE46A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.directions_run),
                        title: const Text('Jogging'),
                        subtitle: const Text('23 Juli 2025, 05:00'),
                        trailing: Checkbox(
                          value: false,
                          onChanged: null,
                        ),
                      ),
                    ),
                    Card(
                      color: Color(0xFFFFE46A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.group),
                        title: const Text('Bermain bersama teman'),
                        subtitle: const Text('23 Juli 2025, 13:00'),
                        trailing: Checkbox(
                          value: false,
                          onChanged: null,
                        ),
                      ),
                    ),
                    Card(
                      color: Color(0xFFFFE46A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.mosque),
                        title: const Text('Sholawat dengan Teman'),
                        subtitle: const Text('24 Juli 2025, 20:00'),
                        trailing: Checkbox(
                          value: false,
                          onChanged: null,
                        ),
                      ),
                    ),
                    Card(
                      color: Color(0xFFFFE46A),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: const Icon(Icons.shopping_bag),
                        title: const Text('Beli skincare'),
                        subtitle: const Text('25 Juli 2025, 09:00'),
                        trailing: Checkbox(
                          value: false,
                          onChanged: null,
                        ),
                      ),
                    ),
                  ],
                )
              ),
            ),
          ],
        ),
      ),
    );
  }
}