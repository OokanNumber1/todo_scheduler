import 'package:flutter/material.dart';
import 'package:todo_app/src/task/data/database_service.dart';
import 'package:todo_app/src/task/view_models/task_view_model.dart';
import 'package:todo_app/src/task/views/input_task_view.dart';
import 'package:todo_app/src/utilities/notification/notification_service.dart';

import 'package:todo_app/src/task/views/tasks_view.dart';

class RouteGenerator {
  static const String routeHome = "/";
  static const String routeError = "/error";
  static const String routeTask = "/task";
  static const String routeTaskEdit = "/task/edit";

  Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case routeHome:
        return _displayRoute(
          TasksView(
            viewModel: TaskViewModel(
              databaseProvider: ImpDatabaseService(),
              notificationService: NotificationService(),
            ),
          ),
        );
      case routeTask:
        return _displayRoute(TasksView(
          viewModel: TaskViewModel(
            databaseProvider: ImpDatabaseService(),
            notificationService: NotificationService(),
          ),
        ));
      case routeTaskEdit:
        return _displayRoute(
          TaskInputView(
            viewmodel: TaskViewModel(
              databaseProvider: ImpDatabaseService(),
              notificationService: NotificationService(),
            ),
          ),
        );

      default:
        return _displayRoute(
          const Scaffold(
            body: Center(
              child: Text(
                'Error Occured',
                style: TextStyle(fontSize: 24, color: Colors.red),
              ),
            ),
          ),
        );
    }
  }

  Route _displayRoute(Widget view) {
    return PageRouteBuilder(pageBuilder: (context, _, __) => view);
  }
}
