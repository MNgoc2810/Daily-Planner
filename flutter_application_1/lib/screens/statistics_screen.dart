// lib/screens/statistics_screen.dart
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Thống kê công việc'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: PieChart(
          PieChartData(
            sections: [
              PieChartSectionData(
                value: 40,
                title: 'Hoàn thành',
                color: Colors.green,
              ),
              PieChartSectionData(
                value: 30,
                title: 'Đang thực hiện',
                color: Colors.blue,
              ),
              PieChartSectionData(
                value: 30,
                title: 'Mới tạo',
                color: Colors.orange,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
