import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFFFFFFFF),
              Color(0xFFEEB7E7),
            ],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(horizontal: 30, vertical: 30),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFFEEAECA),
                    Color(0xFFC06AF2),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                      color: Color(0xFFC06AF2),
                      spreadRadius: 5,
                      blurRadius: 15),
                ],
              ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.arrow_back),
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
                  Text("My Task", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w900),),
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
