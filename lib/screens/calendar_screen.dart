import 'package:flutter/material.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    final now = DateTime.now();
    final days = ['Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
    final currentDayIndex = now.weekday - 1; // 0-based index (Tue = 2)

    return Scaffold(
      appBar: AppBar(
        title: const Text('Today'),
        leading: const Icon(Icons.arrow_back_ios),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Productive Day, Richo',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              '${days[now.weekday - 1]}, ${now.day.toString().padLeft(2, '0')} ${now.month.toString().padLeft(2, '0')} ${now.year}',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: List.generate(7, (index) {
                final date = now.subtract(Duration(days: currentDayIndex - index));
                return Text(
                  date.day.toString(),
                  style: TextStyle(
                    fontWeight: index == currentDayIndex ? FontWeight.bold : FontWeight.normal,
                    color: index == currentDayIndex ? Colors.black : Colors.grey,
                  ),
                );
              }),
            ),
          ),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                _buildTaskItem('5:30 am', 'Do the dishes'),
                _buildTaskItem('6:00 am', 'Run with family'),
                _buildTaskItem('8:00 am', 'Take a bath'),
                _buildTaskItem('1:00 pm', 'Meet with friend'),
                _buildTaskItem('2:45 pm', 'Pray'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskItem(String time, String task) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: time == '2:45 pm' ? Colors.pink[100] : Colors.teal[100],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Text(
            time,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(width: 20),
          Expanded(child: Text(task)),
        ],
      ),
    );
  }
}
