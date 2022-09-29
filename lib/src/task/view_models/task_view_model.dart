import 'package:todo_app/src/task/data/database_service.dart';
import 'package:todo_app/src/task/domain/task.dart';
import 'package:todo_app/src/utilities/notification/notification_service.dart';
import 'package:timezone/timezone.dart';

class TaskViewModel {
  TaskViewModel({
    required this.databaseProvider,
    required this.notificationService,
  });

  final IDatabaseService databaseProvider;
  final NotificationService? notificationService;

  Future<void> addTask(Task task) async {
    await databaseProvider.addTask(task);
    scheduleNotification(
      task,
      task.datePicked,
    );
    task.taskNotty!.isRepeat
        ? scheduleNotification(
            task,
            task.datePicked.add(
              Duration(minutes: task.taskNotty!.repeatInterval!),
            ),
          )
        : scheduleNotification(task, task.datePicked);
  }

  Future<void> updateTask(Task task) async => databaseProvider.updateTask(task);

  Future<void> deleteTask(Task task) async {
    databaseProvider.deleteTask(task);
    notificationService!.cancelNotification(task);
  }

  void scheduleNotification(Task task, TZDateTime date) =>
      notificationService?.scheduleNextNotification(task, date);

  void scheduluePeriodicNotification(Task task) {}
}

// final taskViewmodelProvider = Provider(
//     (ref) => TaskViewModel(databaseProvider: ref.watch(databaseService)));
