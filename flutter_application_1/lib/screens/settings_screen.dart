// lib/screens/settings_screen.dart
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../main.dart'; // Nhập MyApp để truy cập phương thức changeTheme

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _isDarkMode = false; // Biến lưu trạng thái chế độ tối/sáng
  Color _selectedColor = Colors.teal; // Màu sắc được chọn

  @override
  void initState() {
    super.initState();
    _loadThemeMode(); // Tải chế độ sáng/tối từ SharedPreferences
  }

  Future<void> _loadThemeMode() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _isDarkMode = prefs.getBool('isDarkMode') ?? false;
    });
  }

  Future<void> _toggleDarkMode(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkMode', value);
    setState(() {
      _isDarkMode = value;
    });

    // Cập nhật giao diện của ứng dụng
    MyApp.of(context)?.changeTheme(value ? ThemeMode.dark : ThemeMode.light);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cài đặt'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              title: Text('Chế độ tối'),
              value: _isDarkMode,
              onChanged: (bool value) {
                _toggleDarkMode(value); // Gọi hàm để cập nhật chế độ sáng/tối
              },
            ),
            SizedBox(height: 20),
            Text('Chọn màu chính của font chữ:', style: TextStyle(fontSize: 18)),
            DropdownButton<Color>(
              value: _selectedColor,
              onChanged: (Color? newValue) {
                setState(() {
                  _selectedColor = newValue!;
                });
              },
              items: [
                DropdownMenuItem(
                  child: Text('Teal'),
                  value: Colors.teal,
                ),
                DropdownMenuItem(
                  child: Text('Xanh dương'),
                  value: Colors.blue,
                ),
                DropdownMenuItem(
                  child: Text('Đỏ'),
                  value: Colors.red,
                ),
              ],
            ),
            // Thêm các tùy chọn khác nếu cần
          ],
        ),
      ),
    );
  }
}
