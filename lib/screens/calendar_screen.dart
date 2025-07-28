import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({super.key});

  @override
  State<CalenderScreen> createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Kalender')),
      body: SfCalendar(
        view: CalendarView.week,
        dataSource: TaskDataSource(getAppointments()),
      ),
    );
  }

  List<Appointment> getAppointments() {
    List<Appointment> tasks = <Appointment>[];
    final DateTime today = DateTime.now();
    final DateTime startTime =
        DateTime(today.year, today.month, today.day, 9, 0, 0);
    final DateTime endTime = startTime.add(const Duration(hours: 2));

    tasks.add(Appointment(
      startTime: startTime,
      endTime: endTime,
      subject: 'Do the dishes',
      color: const Color.fromRGBO(255, 235, 59, 1),
    ));

    return tasks;
  }
}

class TaskDataSource extends CalendarDataSource {
  TaskDataSource(List<Appointment> source) {
    appointments = source;
  }
}
