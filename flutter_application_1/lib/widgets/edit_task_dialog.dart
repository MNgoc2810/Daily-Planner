// lib/widgets/edit_task_dialog.dart
import 'package:flutter/material.dart';
import '../models/task.dart';

class EditTaskDialog extends StatefulWidget {
  final Task task;
  final Function(Task) onUpdateTask;

  EditTaskDialog({required this.task, required this.onUpdateTask});

  @override
  _EditTaskDialogState createState() => _EditTaskDialogState();
}

class _EditTaskDialogState extends State<EditTaskDialog> {
  late TextEditingController _titleController;
  late TextEditingController _descriptionController;
  late TextEditingController _locationController;
  late TextEditingController _leaderController;
  late TextEditingController _notesController;
  late DateTime _dueDate;
  late TimeOfDay _startTime;
  late TimeOfDay _endTime;
  late String _taskStatus;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.task.title);
    _descriptionController = TextEditingController(text: widget.task.description);
    _locationController = TextEditingController(text: widget.task.location);
    _leaderController = TextEditingController(text: widget.task.leader);
    _notesController = TextEditingController(text: widget.task.notes);
    _dueDate = widget.task.dueDate;
    _startTime = widget.task.startTime;
    _endTime = widget.task.endTime;
    _taskStatus = widget.task.status.toString().split('.').last; 
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Chỉnh sửa công việc', style: TextStyle(color: Colors.teal)),
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
              items: <String>['notStarted', 'inProgress', 'completed', 'finished'].map((String value) {
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
            final updatedTask = Task(
              title: _titleController.text,
              description: _descriptionController.text,
              dueDate: _dueDate,
              startTime: _startTime,
              endTime: _endTime,
              status: _taskStatus == 'notStarted'
                  ? TaskStatus.notStarted
                  : _taskStatus == 'inProgress'
                      ? TaskStatus.inProgress
                      : _taskStatus == 'completed'
                          ? TaskStatus.completed
                          : TaskStatus.finished,
              reviewer: "Người kiểm duyệt", 
              location: _locationController.text,
              leader: _leaderController.text,
              notes: _notesController.text,
            );
            widget.onUpdateTask(updatedTask);
            Navigator.of(context).pop();
          },
          child: Text('Cập nhật', style: TextStyle(color: Colors.white)),
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
