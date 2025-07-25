import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'calender.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              decoration: const BoxDecoration(
                color: Color(0xFFA0D7CB),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFA0D7CB),
                      spreadRadius: 5,
                      blurRadius: 15),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SplashScreen()));
                    },
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Icon(Icons.account_circle_rounded),
                        Text(
                          "Richo and the Gang",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                        Text("Slow Living era's")
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "My Task",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.access_time_filled_rounded),
                      title: Text("To Do"),
                      subtitle: Text("5 Task"),
                    ),
                  ),
                  Card(
                    child: ListTile(
                      leading: Icon(Icons.check_circle_rounded),
                      title: Text("Done"),
                      subtitle: Text("4 Task Done"),
                    ),
                  ),
                  Card(
                    child: Container(
                      margin: EdgeInsets.all(0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => CalenderScreen()),
                              );
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 100, vertical: 20),
                              decoration: const BoxDecoration(
                                color: Color(0xFFA0D7C8),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                              child: ListTile(
                                leading: Icon(
                                  Icons.calendar_month,
                                  size: 20,
                                ),
                                title: Text(" Calendar Appoinment"),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Column -> Floating action button
          ],
        ),
      ),
    );
  }
}
