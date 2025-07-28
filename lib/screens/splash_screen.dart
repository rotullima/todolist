import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  'To Do Day',
                  style: GoogleFonts.poppins(
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFA0D7C8),
                  ),
                ),
                ClipOval(
                  child: Container(
                    width: 326,
                    height: 282,
                    decoration: const BoxDecoration(
                      color: Color(0xFFA0D7C8),
                    ),
                    child: Center(
                      child: Image.asset(
                        'Logo.png',
                        width: 195,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Column(
                    children: [
                      Text(
                        'Get organized  your life',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF584A4A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        'simple and affective\n'
                        'to-do list and task manager app\n'
                        'which helps you manage time\n',
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF584A4A),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HomeScreen(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 90, vertical: 20),
                          decoration: const BoxDecoration(
                            color: Color(0xFFA0D7C8),
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text(
                            'Get Started',
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF584A4A),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
