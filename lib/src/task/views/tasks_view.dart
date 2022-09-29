import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:todo_app/src/task/data/database_service.dart';
import 'package:todo_app/src/task/view_models/task_view_model.dart';
import 'package:todo_app/src/task/views/widgets/task_data_content.dart';
import 'package:todo_app/src/utilities/background_service.dart';
import 'package:todo_app/src/utilities/navigation/route.dart';

class TasksView extends ConsumerStatefulWidget {
  const TasksView({required this.viewModel, Key? key}) : super(key: key);

  final TaskViewModel viewModel;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _TasksViewState();
}

class _TasksViewState extends ConsumerState<TasksView> {
  File? pickedFile;

  Future<bool> pickFile() async {
    return await BackgroundService().pickFile();
  }

  Future<File?> readFile() async {
    pickedFile = File(await ref.read(backgroundProvider).readFile() ?? '');

    return pickedFile;
  }

  @override
  void initState() {
    super.initState();
    readFile();
  }

  @override
  Widget build(BuildContext context) {
    final provider = ref.watch(tasksProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeView'),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) => [
              PopupMenuItem(
                value: 'set',
                onTap: () async {
                  final success = await pickFile();
                  if (success) {
                    setState(() {
                      readFile().then((value) => pickedFile = value);
                    });
                  }
                },
                child: const Text('Set Background Image'),
              ),
              PopupMenuItem(
                value: 'default',
                onTap: () => setState(() {
                  pickedFile = null;
                  //BackgroundService().clear();
                  ref.read(backgroundProvider).clear();
                }),
                child: const Text('Set default Background'),
              ),
            ],
          )
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          image: pickedFile != null
              ? DecorationImage(
                  image: FileImage(pickedFile!),
                  fit: BoxFit.cover,
                )
              : null,
        ),
        child: provider.when(
          data: (tasks) => TasksDataContent(
            ref: ref,
            tasks: tasks,
            viewModel: widget.viewModel,
          ),
          error: (err, skt) => const _ErrorContent(),
          loading: () => const LoadingWidget(),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          Navigator.pushNamed(context, RouteGenerator.routeTaskEdit);
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class _ErrorContent extends StatelessWidget {
  const _ErrorContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Error Occured',
        style: TextStyle(fontSize: 24, color: Colors.red),
      ),
    );
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }
}
