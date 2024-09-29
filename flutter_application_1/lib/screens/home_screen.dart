// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/task.dart';
import 'calendar_screen.dart';
import 'task_list_screen.dart';
import 'settings_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  // Danh sách công việc mẫu để truyền vào các màn hình
  List<Task> taskList = [
    Task(
      title: "Công việc 1",
      status: TaskStatus.notStarted, // Sử dụng enum TaskStatus
      reviewer: "Người kiểm duyệt 1",
      dueDate: DateTime.now(),
      startTime: TimeOfDay(hour: 9, minute: 0), // Giờ bắt đầu
      endTime: TimeOfDay(hour: 10, minute: 0), // Giờ kết thúc
      description: "Mô tả công việc 1",
      location: "Địa điểm 1", // Cung cấp giá trị cho location
      leader: "Người chủ trì 1", // Cung cấp giá trị cho leader
      notes: "Ghi chú cho công việc 1", // Cung cấp giá trị cho notes
    ),
    // Bạn có thể thêm nhiều công việc ở đây
  ];

  // Tạo danh sách màn hình và truyền danh sách công việc vào
  late List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      TaskListScreen(taskList: taskList), // Truyền danh sách công việc vào đây
      CalendarScreen(tasks: taskList), // Truyền danh sách công việc vào đây
      SettingsScreen(),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'Công việc',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            label: 'Lịch',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Cài đặt',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.teal,
        onTap: _onItemTapped,
      ),
    );
  }
}
