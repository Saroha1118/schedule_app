import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import '../models/task.dart';

class TaskProvider with ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => [..._tasks];

  // 加载任务
  Future<void> loadTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final tasksData = prefs.getString('tasks');
    if (tasksData != null) {
      final List<dynamic> decodedTasks = jsonDecode(tasksData);
      _tasks = decodedTasks.map((taskMap) => Task.fromMap(taskMap)).toList();
      notifyListeners();
    }
  }

  // 保存任务
  Future<void> saveTasks() async {
    final prefs = await SharedPreferences.getInstance();
    final encodedTasks = jsonEncode(_tasks.map((task) => task.toMap()).toList());
    await prefs.setString('tasks', encodedTasks);
  }

  // 添加任务
  void addTask(String title, DateTime? startTime, DateTime? endTime) {
    final newTask = Task(
      id: DateTime.now().toString(),
      title: title,
      startTime: startTime,
      endTime: endTime,
    );
    _tasks.add(newTask);
    saveTasks();
    notifyListeners();
  }

  // 更新任务
  void updateTask(String id, String title, DateTime? startTime, DateTime? endTime) {
    final taskIndex = _tasks.indexWhere((task) => task.id == id);
    if (taskIndex >= 0) {
      _tasks[taskIndex] = _tasks[taskIndex].copyWith(
        title: title,
        startTime: startTime,
        endTime: endTime,
      );
      saveTasks();
      notifyListeners();
    }
  }

  // 删除任务
  void deleteTask(String id) {
    _tasks.removeWhere((task) => task.id == id);
    saveTasks();
    notifyListeners();
  }
}
