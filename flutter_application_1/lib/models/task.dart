// lib/models/task.dart
import 'package:flutter/material.dart';

enum TaskStatus {
  notStarted,  // Tạo mới
  inProgress,  // Đang thực hiện
  completed,   // Thành công
  finished, ended,    // Kết thúc
}


class Task {
 final String title;
  TaskStatus status;  // Thay đổi thành mutable
  final String reviewer;  // Tên người kiểm duyệt
  final DateTime dueDate;
  final TimeOfDay startTime;
  final TimeOfDay endTime;
  final String description;
  final String location;
  final String leader;
  final String notes;

  Task({
    required this.title,
    this.status = TaskStatus.notStarted,
    required this.reviewer,
    required this.dueDate,
    required this.startTime,
    required this.endTime,
    required this.description,
    required this.location,
    required this.leader,
    required this.notes,
  });
}
