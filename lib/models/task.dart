import 'package:flutter/foundation.dart';

class Task {
  final String id;
  final String title;
  final DateTime? startTime;
  final DateTime? endTime;

  Task({
    required this.id,
    required this.title,
    this.startTime,
    this.endTime,
  });

  // Add the copyWith method
  Task copyWith({
    String? id,
    String? title,
    DateTime? startTime,
    DateTime? endTime,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      startTime: startTime ?? this.startTime,
      endTime: endTime ?? this.endTime,
    );
  }

  // Convert Task to Map for persistence
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'startTime': startTime?.toIso8601String(),
      'endTime': endTime?.toIso8601String(),
    };
  }

  // Convert Map to Task
  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'],
      title: map['title'],
      startTime: map['startTime'] != null
          ? DateTime.parse(map['startTime'])
          : null,
      endTime: map['endTime'] != null ? DateTime.parse(map['endTime']) : null,
    );
  }
}
