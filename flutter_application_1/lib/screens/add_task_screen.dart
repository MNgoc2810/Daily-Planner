import 'package:flutter/material.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _dateController = TextEditingController();
  final _contentController = TextEditingController();
  final _timeController = TextEditingController();
  final _locationController = TextEditingController();
  final _noteController = TextEditingController();
  String _selectedPerson = 'Thanh Ngân';
  List<String> _persons = ['Thanh Ngân', 'Hữu Nghĩa'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _dateController,
              decoration: InputDecoration(labelText: 'Date (e.g. Monday, 23/09/2024)'),
            ),
            TextField(
              controller: _contentController,
              decoration: InputDecoration(labelText: 'Task Content'),
            ),
            TextField(
              controller: _timeController,
              decoration: InputDecoration(labelText: 'Time (e.g. 8h->11h)'),
            ),
            TextField(
              controller: _locationController,
              decoration: InputDecoration(labelText: 'Location'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedPerson,
              items: _persons.map((String person) {
                return DropdownMenuItem<String>(
                  value: person,
                  child: Text(person),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedPerson = newValue!;
                });
              },
              decoration: InputDecoration(labelText: 'Person in Charge'),
            ),
            TextField(
              controller: _noteController,
              decoration: InputDecoration(labelText: 'Note'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(
                  context,
                  _contentController.text, // Return task content as new task
                );
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
