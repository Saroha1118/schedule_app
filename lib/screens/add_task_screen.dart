import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';

class AddTaskScreen extends StatefulWidget {
  @override
  _AddTaskScreenState createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final _titleController = TextEditingController();
  DateTime? _startTime;
  DateTime? _endTime;

  void _pickStartTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null) return;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return;

    setState(() {
      _startTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  void _pickEndTime() async {
    final pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate == null) return;
    final pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (pickedTime == null) return;

    setState(() {
      _endTime = DateTime(
        pickedDate.year,
        pickedDate.month,
        pickedDate.day,
        pickedTime.hour,
        pickedTime.minute,
      );
    });
  }

  void _saveTask() {
    final title = _titleController.text;
    if (title.isEmpty || _startTime == null || _endTime == null) {
      return;
    }

    if (_startTime!.isAfter(_endTime!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('开始时间不能晚于结束时间！')),
      );
      return;
    }

    Provider.of<TaskProvider>(context, listen: false).addTask(
      title,
      _startTime,
      _endTime,
    );
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('添加日程')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: '日程内容'),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _startTime == null
                      ? '还没有选择开始时间!'
                      : '开始: ${_startTime.toString()}',
                ),
                TextButton(
                  onPressed: _pickStartTime,
                  child: Text('选择开始时间'),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _endTime == null
                      ? '还没有选择结束时间！'
                      : '结束: ${_endTime.toString()}',
                ),
                TextButton(
                  onPressed: _pickEndTime,
                  child: Text('选择结束时间'),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveTask,
              child: Text('添加'),
            ),
          ],
        ),
      ),
    );
  }
}
