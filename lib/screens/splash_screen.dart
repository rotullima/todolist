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
                          fontWeight: FontWeight.w700,
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
                          fontWeight: FontWeight.w600,
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
                          showModalBottomSheet(
                              isScrollControlled: true,
                              context: context,
                              builder: (context) {
                                return StatefulBuilder(
                                  builder: (BuildContext context,
                                      StateSetter setState) {
                                    return Wrap(
                                      children: [
                                        Container(
                                            child: Container(
                                          decoration: BoxDecoration(
                                              color: Color(0xFFA0D7C8),
                                              borderRadius: BorderRadius.only(
                                                  topRight: Radius.circular(30),
                                                  topLeft:
                                                      Radius.circular(30))),
                                          child: Container(
                                            margin: EdgeInsets.symmetric(
                                                vertical: 50),
                                            child: Column(
                                              children: [
                                                SizedBox(
                                                  height: 25,
                                                ),
                                                Text(
                                                  'Create Account',
                                                  style: GoogleFonts.poppins(
                                                    fontSize: 24,
                                                    fontWeight: FontWeight.bold,
                                                    color: Color(0xFF584A4A),
                                                  ),
                                                ),
                                                SizedBox(
                                                  height: 25,
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                      labelStyle: TextStyle(
                                                        color: Colors.white,
                                                      ),
                                                      border: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              BorderSide(
                                                                  color: Colors
                                                                      .white,
                                                                  width: 30.0)),
                                                      hintText:
                                                          "infoexample.com",
                                                      labelText:
                                                          "username/email",
                                                      suffixIcon: InkWell(
                                                        onTap: () {},
                                                        child: Icon(Icons
                                                            .visibility_outlined),
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      hintText: "course",
                                                      labelText: "course",
                                                      suffixIcon: InkWell(
                                                        onTap: () {},
                                                        child: Icon(Icons
                                                            .visibility_outlined),
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      hintText: "password",
                                                      labelText: "password",
                                                      suffixIcon: InkWell(
                                                        onTap: () {},
                                                        child: Icon(Icons
                                                            .visibility_outlined),
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                TextField(
                                                  decoration: InputDecoration(
                                                      border:
                                                          OutlineInputBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                      ),
                                                      hintText:
                                                          "confirm password",
                                                      labelText:
                                                          "confirm password",
                                                      suffixIcon: InkWell(
                                                        onTap: () {},
                                                        child: Icon(Icons
                                                            .visibility_outlined),
                                                      )),
                                                ),
                                                SizedBox(
                                                  height: 20,
                                                ),
                                                GestureDetector(
                                                    onTap: () {
                                                      Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              const HomeScreen(),
                                                        ),
                                                      );
                                                    },
                                                    child: Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                          horizontal: 35,
                                                          vertical: 15),
                                                      decoration:
                                                          const BoxDecoration(
                                                        color: Colors.white,
                                                        borderRadius:
                                                            BorderRadius.all(
                                                                Radius.circular(
                                                                    20)),
                                                      ),
                                                      child: Text(
                                                        'Register',
                                                        style:
                                                            GoogleFonts.poppins(
                                                          fontSize: 18,
                                                          fontWeight:
                                                              FontWeight.w600,
                                                          color:
                                                              Color(0xFF584A4A),
                                                        ),
                                                      ),
                                                    )),
                                              ],
                                            ),
                                          ),
                                        ))
                                      ],
                                    );
                                  },
                                );
                              });
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
