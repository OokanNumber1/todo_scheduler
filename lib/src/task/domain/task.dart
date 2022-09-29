import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:todo_app/src/task/domain/task_notification.dart';

@immutable
class Task extends Equatable {
  final String id;
  final String title;
  final String description;
  final tz.TZDateTime datePicked;
  final TaskNotification? taskNotty;
  const Task(
      {required this.id,
      required this.title,
      required this.description,
      required this.datePicked,
      this.taskNotty});

  @override
  List<Object?> get props => [id, title, description, datePicked];

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'created': datePicked.millisecondsSinceEpoch,
      'taskNoty': taskNotty != null ? taskNotty!.toMap() : null
    };
  }

  factory Task.fromMap(Map<String, dynamic> map) {
    return Task(
      id: map['id'] ?? '',
      title: map['title'] ?? '',
      description: map['description'] ?? '',
      taskNotty: map['taskNotty'] ?? TaskNotification.empty(),
      datePicked:
          tz.TZDateTime.fromMillisecondsSinceEpoch(tz.local, map['created']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Task.fromJson(String source) => Task.fromMap(json.decode(source));
}
