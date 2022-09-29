import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/task/data/database_service.dart';
import 'package:todo_app/src/task/domain/task.dart';
import 'package:todo_app/src/task/view_models/task_view_model.dart';
import 'package:todo_app/src/task/views/input_task_view.dart';

class TasksDataContent extends StatelessWidget {
  const TasksDataContent({
    required this.ref,
    required this.tasks,
    required this.viewModel,
    Key? key,
  }) : super(key: key);
  final TaskViewModel viewModel;
  final WidgetRef ref;
  final List<Task> tasks;
  @override
  Widget build(BuildContext context) {
    return tasks.isEmpty
        ? const Center(
            child: Text(
              'No data Found',
              style: TextStyle(backgroundColor: Colors.white38),
            ),
          )
        : ListView.builder(
            itemCount: tasks.length,
            itemBuilder: (context, index) {
              final item = tasks[index];
              return ListTile(
                onTap: () async {
                  await viewModel.deleteTask(item);
                  ref.refresh(tasksProvider);
                },
                leading: CircleAvatar(
                  radius: 32,
                  backgroundColor: Colors.grey[400],
                  child: Text(
                    item.id,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                        fontSize: 24,
                        color: Colors.white
                        ),
                  ),
                ),
                title: Text(
                  item.title,
                  style: const TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.black38,
                  ),
                ),
                subtitle: Text(
                  item.description,
                  style: const TextStyle(
                    color: Colors.white,
                    backgroundColor: Colors.black38,
                  ),
                ),
                trailing: CircleAvatar(
                  radius: 20,
                  backgroundColor: Colors.white38,
                  child: IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TaskInputView(
                            viewmodel: viewModel,
                            task: item,
                          ),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit),
                  ),
                ),
                isThreeLine: true,
              );
            });
  }
}
