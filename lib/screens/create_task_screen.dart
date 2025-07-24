import 'package:flutter/material.dart';

class CreateTaskScreen extends StatelessWidget {
  const CreateTaskScreen({super.key});

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
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
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
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.arrow_back),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: const[
                          Text(
                            'Add New Task',
                            style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ],
                      ),
                      ),
                      const SizedBox(width: 24,),
                      const Text(
                        'Task Title',
                        style:TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color(0xFFEEAECA),
                              Color(0xFFC06AF2),
                            ],
                          ),
                          borderRadius: BorderRadius.all(12),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: const Text(
                          'Task Title',
                          style: TextStyle(color: Colors.black45),
                        ),
                      ),
                      const SizedBox(height: 24),
                      const Text(
                        'Category',
                        style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),
                      ),
                      const SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: const [
                          
                        ],
                      )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
