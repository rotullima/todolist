import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  // Function to show the Register modal
  void _showRegisterModal(BuildContext context) {
    bool isPasswordVisible = false; // State for password visibility
    bool isConfirmPasswordVisible = false; // State for confirm password visibility

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  width: 550,
                  height: 550,
                  decoration: BoxDecoration(
                    color: Color(0xFFA0D7C8),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'Create Account',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF584A4A),
                        ),
                      ),
                      SizedBox(height: 25),
                      SizedBox(
                        width: 400,
                        height: 60,
                        child: TextField(
                          decoration: InputDecoration(
                            labelStyle: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            hintText: "infoexample.com",
                            hintStyle: TextStyle(color: Colors.white),
                            labelText: "username/email",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 3.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 3.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 400,
                        height: 60,
                        child: TextField(
                          decoration: InputDecoration(
                            labelStyle: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            hintText: "course",
                            hintStyle: TextStyle(color: Colors.white),
                            labelText: "course",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 3.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 3.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 400,
                        height: 60,
                        child: TextField(
                          obscureText: !isPasswordVisible, // Toggle password visibility
                          decoration: InputDecoration(
                            labelStyle: GoogleFonts.poppins(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.w600),
                            hintText: "password",
                            hintStyle: TextStyle(color: Colors.white),
                            labelText: "password",
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible; // Toggle state
                                });
                              },
                              child: Icon(
                                isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 3.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 3.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 400,
                        height: 60,
                        child: TextField(
                          obscureText: !isConfirmPasswordVisible, // Toggle confirm password visibility
                          decoration: InputDecoration(
                            labelStyle: GoogleFonts.poppins(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                            hintText: "confirm password",
                            hintStyle: TextStyle(color: Colors.white),
                            labelText: "confirm password",
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  isConfirmPasswordVisible = !isConfirmPasswordVisible; // Toggle state
                                });
                              },
                              child: Icon(
                                isConfirmPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 3.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 3.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
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
                          width: 400,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text(
                            'Register',
                            style: GoogleFonts.poppins(
                              fontSize: 18,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF584A4A),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Already have account? ',
                            style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF584A4A)),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Close Register modal
                              _showLoginModal(context); // Open Login modal
                            },
                            child: Text(
                              'Login',
                              style: GoogleFonts.poppins(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  // Function to show the Login modal
  void _showLoginModal(BuildContext context) {
    bool isPasswordVisible = false; // State for password visibility

    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Wrap(
              children: [
                Container(
                  width: 550,
                  height: 400,
                  decoration: BoxDecoration(
                    color: Color(0xFFA0D7C8),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: 30),
                      Text(
                        'Login',
                        style: GoogleFonts.poppins(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF584A4A),
                        ),
                      ),
                      SizedBox(height: 10),
                      SizedBox(
                        width: 400,
                        height: 60,
                        child: TextField(
                          decoration: InputDecoration(
                            labelStyle: GoogleFonts.poppins(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                            hintText: "ricko11@gmail.com",
                            hintStyle: TextStyle(color: Colors.white),
                            labelText: "Username/email",
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 3.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 3.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      SizedBox(
                        width: 400,
                        height: 60,
                        child: TextField(
                          obscureText: !isPasswordVisible, // Toggle password visibility
                          decoration: InputDecoration(
                            labelStyle: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            hintText: "12345678",
                            hintStyle: TextStyle(color: Colors.white),
                            labelText: "password",
                            suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  isPasswordVisible = !isPasswordVisible; // Toggle state
                                });
                              },
                              child: Icon(
                                isPasswordVisible
                                    ? Icons.visibility_off_outlined
                                    : Icons.visibility_outlined,
                                color: Colors.white,
                                size: 26,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 3.0),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                              borderSide: BorderSide(color: Colors.white, width: 3.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
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
                          width: 400,
                          height: 60,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Text(
                            'Login',
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              color: Color(0xFF584A4A),
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Don’t have an account? ',
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Color(0xFF584A4A),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.pop(context); // Close Login modal
                              _showRegisterModal(context); // Open Register modal
                            },
                            child: Text(
                              'Register',
                              style: GoogleFonts.poppins(
                                fontSize: 20,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

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
                    fontWeight: FontWeight.w700,
                    color: Color(0xFFA0D7C8),
                  ),
                ),
                ClipOval(
                  child: Container(
                    width: 326,
                    height: 282,
                    decoration: const BoxDecoration(
                      color: Color(0xFFA0D7C8),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black26,
                          offset: Offset(0, 4),
                          blurRadius: 10,
                          spreadRadius: 20,
                        ),
                      ],
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
                Column(
                  children: [
                    Text(
                      'Get organized your life',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF584A4A),
                      ),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      'simple and effective\n'
                      'to-do list and task manager app\n'
                      'which helps you manage time\n',
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF584A4A),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _showRegisterModal(context), // Show Register modal
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 90, vertical: 20),
                        decoration: const BoxDecoration(
                          color: Color(0xFFA0D7C8),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          'Create Account',
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () => _showLoginModal(context), // Show Login modal
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Color(0xFFA0D7C8), width: 3.0),
                          borderRadius: BorderRadius.all(Radius.circular(20)),
                        ),
                        child: Text(
                          'Login',
                          style: GoogleFonts.poppins(
                            fontSize: 24,
                            fontWeight: FontWeight.w700,
                            color: Color(0xFFA0D7C8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}