// lib/screens/task_list_screen.dart
import 'package:flutter/material.dart';
import '../models/task.dart';
import '../widgets/add_task_dialog.dart';
import '../widgets/edit_task_dialog.dart'; // Nhập dialog chỉnh sửa công việc

class TaskListScreen extends StatefulWidget {
  final List<Task> taskList;

  TaskListScreen({required this.taskList});

  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Danh sách công việc'),
        backgroundColor: Colors.teal,
      ),
      body: ListView.builder(
        itemCount: widget.taskList.length,
        itemBuilder: (context, index) {
          final task = widget.taskList[index];
          return Card(
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 10),
            child: ListTile(
              title: Text(task.title),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Trạng thái: ${task.status.toString().split('.').last}"),
                  Text("Người kiểm duyệt: ${task.reviewer}"),
                  Text("Ngày đến hạn: ${task.dueDate.toLocal()}".split(' ')[0]),
                  Text("Nội dung: ${task.description}"),
                  Text("Địa điểm: ${task.location}"),
                  Text("Chủ trì: ${task.leader}"),
                  Text("Ghi chú: ${task.notes}"),
                ],
              ),
              onTap: () {
                // Mở dialog chỉnh sửa công việc khi nhấn vào
                _editTask(task);
              },
              trailing: IconButton(
                icon: Icon(Icons.delete, color: Colors.red),
                onPressed: () {
                  _confirmDeleteTask(index); // Gọi hàm xác nhận xóa công việc
                },
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showDialog(
          context: context,
          builder: (context) => AddTaskDialog(onAddTask: (task) {
            setState(() {
              widget.taskList.add(task); // Cập nhật danh sách công việc
            });
          }),
        ),
        child: Icon(Icons.add),
        backgroundColor: Colors.teal,
      ),
    );
  }

  void _editTask(Task task) {
    showDialog(
      context: context,
      builder: (context) => EditTaskDialog(
        task: task,
        onUpdateTask: (updatedTask) {
          setState(() {
            int index = widget.taskList.indexOf(task);
            widget.taskList[index] = updatedTask; // Cập nhật công việc
          });
        },
      ),
    );
  }

  void _updateTaskStatus(Task task) {
    setState(() {
      if (task.status == TaskStatus.notStarted) {
        task.status = TaskStatus.inProgress; // Đang thực hiện
      } else if (task.status == TaskStatus.inProgress) {
        task.status = TaskStatus.completed;   // Thành công
      } else if (task.status == TaskStatus.completed) {
        task.status = TaskStatus.ended;       // Kết thúc
      }
    });
  }

  void _confirmDeleteTask(int index) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Xác nhận xóa'),
        content: Text('Bạn có chắc chắn muốn xóa công việc này không?'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop(); // Đóng dialog
            },
            child: Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              _deleteTask(index); // Gọi hàm xóa công việc
              Navigator.of(context).pop(); // Đóng dialog
            },
            child: Text('Xóa'),
          ),
        ],
      ),
    );
  }

  void _deleteTask(int index) {
    setState(() {
      widget.taskList.removeAt(index); // Xóa công việc theo chỉ số
    });
  }
}
