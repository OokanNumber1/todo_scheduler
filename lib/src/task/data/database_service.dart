import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_app/src/task/domain/task.dart';


abstract class IDatabaseService {
  Future<void> addTask(Task task);
  Future<List<Task>> getTasks();
  Future<void> updateTask(Task task);
  Future<void> deleteTask(Task task);
}

class ImpDatabaseService implements IDatabaseService {
  final _boxId = 'tasksP';
  @override
  Future<void> addTask(Task task) async {
    var box = await Hive.openBox(_boxId);
    await box.put(task.id, task.toJson());
    await box.close();
  }

  @override
  Future<List<Task>> getTasks() async {
    var box = await Hive.openBox(_boxId);
    var res = box.values.map((entry) => Task.fromJson(entry)).toList();
    return res;
  }

  @override
  Future<void> updateTask(Task task) async {
    var box = await Hive.openBox(_boxId);
    box.put(task.id, task);
  }

  @override
  Future<void> deleteTask(Task task) async {
    var box = await Hive.openBox(_boxId);
    await box.delete(task.id);
    await box.close();
  }
}

final databaseService =
    Provider<IDatabaseService>((ref) => ImpDatabaseService());

final tasksProvider =
    FutureProvider((ref) => ref.watch(databaseService).getTasks());