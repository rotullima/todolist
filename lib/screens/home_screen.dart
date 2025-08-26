import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'calendar_screen.dart';
import 'task_todo_screen.dart';
import 'task_done_screen.dart';
import 'my_profile_screen.dart';
import 'create_task_screen.dart';
import '../services/auth_services.dart';
import '../services/task_service.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final authServices = AuthServices();
    final taskServices = TaskServices();

    // ambil ukuran layar
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // biar bisa scroll di layar kecil
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              FutureBuilder(
                future: authServices.getUserProfile(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return SizedBox(
                      height: screenHeight * 0.3,
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  }
                  if (snapshot.hasError) {
                    return SizedBox(
                      height: screenHeight * 0.3,
                      child: Center(child: Text('Error: ${snapshot.error}')),
                    );
                  }

                  final profile = snapshot.data ?? {};
                  return Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: screenWidth * 0.08,
                      vertical: screenHeight * 0.05,
                    ),
                    decoration: const BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black12,
                          blurRadius: 8,
                          offset: Offset(0, 4),
                        ),
                      ],
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
                        Container(
                          width: screenWidth * 0.18,
                          height: screenWidth * 0.18,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black12,
                                blurRadius: 10,
                                offset: Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Icon(
                            Icons.account_circle_outlined,
                            size: screenWidth * 0.16,
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.03),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Hello, ${profile['name'] ?? 'User'}',
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w800,
                                  fontSize: screenWidth * 0.06,
                                  color: const Color(0xFF584A4A),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                '${profile['bio'] ?? 'Slow Living'}',
                                style: GoogleFonts.poppins(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w500,
                                  color: const Color(0xFF584A4A),
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              ),

              SizedBox(height: screenHeight * 0.02),

              // Wrapper Menu Home Screen
              Padding(
                padding: EdgeInsets.all(screenWidth * 0.08),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'My Task',
                      style: GoogleFonts.poppins(
                        fontSize: screenWidth * 0.06,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF584A4A),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TaskTodoScreen(),
                          ),
                        );
                        setState(() {}); // refresh
                      },
                      child: FutureBuilder<int>(
                        future: taskServices.getUserPendingTaskCount(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const Text("Loading...");
                          return _menuCard(
                            screenWidth: screenWidth,
                            color: const Color(0xFFA0D7C8),
                            icon: Icons.assignment_outlined,
                            title: 'To Do List',
                            subtitle: '${snapshot.data} Task Now',
                          );
                        },
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const TaskDoneScreen(),
                          ),
                        );
                        setState(() {}); // refresh
                      },
                      child: FutureBuilder<List<int>>(
                        future: Future.wait([
                          taskServices.getUserTaskCount(),
                          taskServices.getUserDoneTaskCount()
                        ]),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) return const Text("Loading...");
                          final total = snapshot.data![0];
                          final done = snapshot.data![1];
                          return _menuCard(
                            screenWidth: screenWidth,
                            color: const Color(0xFFA0D7C8),
                            icon: Icons.check_circle_outline,
                            title: 'To Do Done',
                            subtitle: '$total Task | $done Task Done',
                          );
                        },
                      ),
                    ),

                    SizedBox(height: screenHeight * 0.02),
                    GestureDetector(
                      onTap: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const CalenderScreen(),
                          ),
                        );
                        setState(() {}); // refresh
                      },
                      child: _menuCard(
                        screenWidth: screenWidth,
                        color: const Color(0xFFA0D7C8),
                        icon: Icons.calendar_month,
                        title: 'Calendar Appointment',
                        subtitle: DateFormat('EEEE, d MMMM yyyy').format(DateTime.now()),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: screenHeight * 0.01),

              // Thank You Card
              Center(
                child: Container(
                  width: screenWidth * 0.9,
                  padding: EdgeInsets.all(screenWidth * 0.04),
                  decoration: BoxDecoration(
                    color: const Color(0xFFA0D7C8),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Text(
                    "Organize your day, get things done, and feel accomplished. \n"
                    "Use '+' to add a task.",
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.1),
            ],
          ),
        ),
      ),

      // NAVIGASI MENU BAWAH
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        height: screenWidth * 0.2,
        width: screenWidth * 0.2,
        child: FloatingActionButton(
          shape: const CircleBorder(),
          backgroundColor: const Color(0xFFA0D7C8),
          elevation: 0,
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const CreateTaskScreen(),
              ),
            );
            setState(() {}); // refresh
          },
          child: Icon(
            Icons.add,
            size: screenWidth * 0.12,
            color: Colors.black,
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        color: const Color(0xFFA0D7C8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                );
              },
              icon: Icon(
                Icons.home,
                color: const Color(0xFF584A4A),
                size: screenWidth * 0.1,
              ),
            ),
            SizedBox(width: screenWidth * 0.25),
            IconButton(
              onPressed: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MyProfileScreen(),
                  ),
                );
                setState(() {}); // refresh
              },
              icon: Icon(
                Icons.person,
                color: const Color(0xFF584A4A),
                size: screenWidth * 0.1,
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _menuCard({
    required double screenWidth,
    required Color color,
    required IconData icon,
    required String title,
    String? subtitle,
  }) {
    return Container(
      padding: EdgeInsets.all(screenWidth * 0.05),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: screenWidth * 0.18,
            height: screenWidth * 0.18,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
            child: Icon(icon, size: screenWidth * 0.13),
          ),
          SizedBox(width: screenWidth * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.poppins(
                    fontSize: screenWidth * 0.05,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF584A4A),
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                if (subtitle != null)
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      fontSize: screenWidth * 0.035,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF584A4A),
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}