// lib/widgets/add_task_dialog.dart
import 'package:flutter/material.dart';
import '../models/task.dart';

class AddTaskDialog extends StatefulWidget {
  final Function(Task) onAddTask;

  AddTaskDialog({required this.onAddTask});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _leaderController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();
  DateTime _dueDate = DateTime.now();
  TimeOfDay _startTime = TimeOfDay.now();
  TimeOfDay _endTime = TimeOfDay.now();
  String _taskStatus = 'Tạo mới';

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thêm công việc', style: TextStyle(color: Colors.teal)),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(
                labelText: 'Tiêu đề',
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                labelText: 'Nội dung công việc',
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(
                labelText: 'Địa điểm',
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            TextField(
              controller: _leaderController,
              decoration: InputDecoration(
                labelText: 'Người chủ trì',
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            TextField(
              controller: _notesController,
              decoration: InputDecoration(
                labelText: 'Ghi chú',
                labelStyle: TextStyle(color: Colors.teal),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.teal),
                ),
              ),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Ngày đến hạn: ${_dueDate.toLocal().toString().split(' ')[0]}"),
                TextButton(
                  onPressed: () {
                    _selectDate(context);
                  },
                  child: Text("Chọn ngày", style: TextStyle(color: Colors.teal)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Giờ bắt đầu: ${_startTime.format(context)}"),
                TextButton(
                  onPressed: () {
                    _selectStartTime(context);
                  },
                  child: Text("Chọn giờ", style: TextStyle(color: Colors.teal)),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Giờ kết thúc: ${_endTime.format(context)}"),
                TextButton(
                  onPressed: () {
                    _selectEndTime(context);
                  },
                  child: Text("Chọn giờ", style: TextStyle(color: Colors.teal)),
                ),
              ],
            ),
            SizedBox(height: 10),
            DropdownButton<String>(
              value: _taskStatus,
              items: <String>['Tạo mới', 'Thực hiện', 'Thành công', 'Kết thúc'].map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value, style: TextStyle(color: Colors.teal)),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _taskStatus = newValue!;
                });
              },
              underline: Container(
                height: 1,
                color: Colors.teal,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('Hủy', style: TextStyle(color: Colors.teal)),
        ),
        ElevatedButton(
          onPressed: () {
            final task = Task(
              title: _titleController.text,
              description: _descriptionController.text,
              dueDate: _dueDate,
              startTime: _startTime,
              endTime: _endTime,
              status: _taskStatus == 'Tạo mới'
                  ? TaskStatus.notStarted
                  : _taskStatus == 'Thực hiện'
                      ? TaskStatus.inProgress
                      : _taskStatus == 'Thành công'
                          ? TaskStatus.completed
                          : TaskStatus.finished,
              reviewer: "Người kiểm duyệt", // Có thể thay đổi nếu cần
              location: _locationController.text,
              leader: _leaderController.text,
              notes: _notesController.text,
            );
            widget.onAddTask(task);
            Navigator.of(context).pop();
          },
          child: Text('Thêm', style: TextStyle(color: Colors.white)),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
        ),
      ],
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _dueDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _dueDate) {
      setState(() {
        _dueDate = picked;
      });
    }
  }

  Future<void> _selectStartTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _startTime,
    );
    if (picked != null && picked != _startTime) {
      setState(() {
        _startTime = picked;
      });
    }
  }

  Future<void> _selectEndTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _endTime,
    );
    if (picked != null && picked != _endTime) {
      setState(() {
        _endTime = picked;
      });
    }
  }
}
