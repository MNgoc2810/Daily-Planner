// lib/screens/calendar_screen.dart
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../models/task.dart';
import 'task_detail_screen.dart';

class CalendarScreen extends StatefulWidget {
  final List<Task> tasks;

  CalendarScreen({required this.tasks});

  @override
  _CalendarScreenState createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {
  DateTime _selectedDay = DateTime.now();
  Map<DateTime, List<Task>> _events = {};

  @override
  void initState() {
    super.initState();
    _loadEvents(); // Tải công việc khi khởi tạo
  }

  void _loadEvents() {
    for (var task in widget.tasks) {
      final dueDate = DateTime(task.dueDate.year, task.dueDate.month, task.dueDate.day);
      print("Adding task: ${task.title} to date: $dueDate"); // Debug: in ra công việc được thêm
      if (_events[dueDate] == null) {
        _events[dueDate] = [];
      }
      _events[dueDate]!.add(task);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lịch công việc'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          TableCalendar(
            firstDay: DateTime.utc(2020, 1, 1),
            lastDay: DateTime.utc(2100, 12, 31),
            focusedDay: _selectedDay,
            selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
            onDaySelected: (selectedDay, focusedDay) {
              setState(() {
                _selectedDay = selectedDay; // Cập nhật ngày chọn
                _loadEvents(); // Tải lại các công việc
              });
            },
          ),
          Expanded(
            child: _buildTaskListForSelectedDay(),
          ),
        ],
      ),
    );
  }

  Widget _buildTaskListForSelectedDay() {
    final tasksForSelectedDay = _events[_selectedDay] ?? [];
    return ListView.builder(
      itemCount: tasksForSelectedDay.length,
      itemBuilder: (context, index) {
        final task = tasksForSelectedDay[index];
        return Card(
          margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: ListTile(
            title: Text(task.title),
            subtitle: Text("Trạng thái: ${task.status.toString().split('.').last}"),
            trailing: Text("Hạn: ${task.dueDate.toLocal()}".split(' ')[0]),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TaskDetailScreen(task: task),
                ),
              );
            },
          ),
        );
      },
    );
  }
}
