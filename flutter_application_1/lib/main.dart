// lib/main.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/login_screen.dart'; // Nhập màn hình đăng nhập

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Đảm bảo rằng Flutter đã được khởi tạo
  ThemeMode themeMode = await _loadThemeMode(); // Tải chế độ từ shared preferences

  runApp(MyApp(themeMode: themeMode));
}

Future<ThemeMode> _loadThemeMode() async {
  final prefs = await SharedPreferences.getInstance();
  final isDarkMode = prefs.getBool('isDarkMode') ?? false; // Mặc định là false
  return isDarkMode ? ThemeMode.dark : ThemeMode.light;
}

class MyApp extends StatefulWidget {
  final ThemeMode themeMode;

  MyApp({required this.themeMode});

  static _MyAppState? of(BuildContext context) => context.findAncestorStateOfType<_MyAppState>();

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late ThemeMode themeMode;

  @override
  void initState() {
    super.initState();
    themeMode = widget.themeMode;
  }

  void changeTheme(ThemeMode newTheme) {
    setState(() {
      themeMode = newTheme;
    });
    // Lưu trạng thái chế độ sáng/tối vào SharedPreferences
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool('isDarkMode', newTheme == ThemeMode.dark);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Daily Planner',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.teal,
        brightness: Brightness.dark,
      ),
      themeMode: themeMode, // Đặt chế độ ánh sáng/tối
      home: LoginScreen(), // Đặt LoginScreen làm trang đầu tiên
    );
  }
}
