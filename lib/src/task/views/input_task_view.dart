import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:timezone/timezone.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/src/task/data/database_service.dart';
import 'package:todo_app/src/task/domain/task.dart';
import 'package:todo_app/src/task/domain/task_notification.dart';
import 'package:todo_app/src/task/view_models/task_view_model.dart';

class RepeatDay {
  RepeatDay({required this.day, this.value = false});
  final String day;
  bool value;
}

class TaskInputView extends HookConsumerWidget {
  const TaskInputView({this.task, required this.viewmodel, Key? key})
      : super(key: key);
  final TaskViewModel viewmodel;
  final Task? task;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final dateTimePicked = useState(TZDateTime.now(local));
    void _showDateTimeDialog() async {
      DateTime? _date = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now().subtract(
          const Duration(minutes: 1),
        ),
        lastDate: DateTime.now().add(
          const Duration(days: 100),
        ),
      );

      if (_date != null) {
        TimeOfDay? _time = await showTimePicker(
            context: context, initialTime: TimeOfDay.now());
        _time != null
            ? dateTimePicked.value = TZDateTime(local, _date.year, _date.month,
                _date.day, _time.hour, _time.minute)
            : null;
      }
    }

    final scheduleWithMinute = useState(false);
    // final daysValue = List.generate(7, (index) => useState(false));
    final minuteInterval = useTextEditingController();
    //final repeatType = useState(RepeatType.daysRepeat);
    final identifier =
        useTextEditingController(text: task != null ? task!.id : null);
    final title =
        useTextEditingController(text: task != null ? task!.title : null);
    final description =
        useTextEditingController(text: task != null ? task!.description : null);

    // List days = [
    //   RepeatDay(day: 'Mondays', value: daysValue[0].value),
    //   RepeatDay(day: 'Tuesdays', value: daysValue[1].value),
    //   RepeatDay(day: 'Wednesdays', value: daysValue[2].value),
    //   RepeatDay(day: 'Thursdays', value: daysValue[3].value),
    //   RepeatDay(day: 'Fridays', value: daysValue[4].value),
    //   RepeatDay(day: 'Saturdays', value: daysValue[5].value),
    //   RepeatDay(day: 'Sundays', value: daysValue[6].value),
    // ];

    return Scaffold(
      appBar: AppBar(
        title: Text(task != null ? 'Update Task' : 'Add Task'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextField(
                controller: identifier,
                decoration: InputDecoration(
                  hintText: 'Identifier',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  labelText: 'Identifier ',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: 'Title',
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  labelText: 'Title ',
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: description,
                maxLines: 4,
                decoration: InputDecoration(
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  hintText: 'Description',
                  labelText: 'Description ',
                ),
              ),
              const SizedBox(height: 20),
              const Text('Reminder.'),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    scheduleWithMinute.value
                        ? 'Set Remider'
                        : DateFormat('EEE, d/M/y HH:mm').format(
                            task != null
                                ? task!.datePicked
                                : dateTimePicked.value,
                          ),
                  ),
                  IconButton(
                    onPressed: () => _showDateTimeDialog(),
                    padding: EdgeInsets.zero,
                    icon: const Icon(Icons.calendar_view_month),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Checkbox(
                      value: scheduleWithMinute.value,
                      onChanged: (newValue) =>
                          scheduleWithMinute.value = newValue!),
                  const Expanded(
                    child: Text(
                        'Schedule this task to a particular time with minutes?'),
                  )
                ],
              ),
              const SizedBox(height: 12),
              scheduleWithMinute.value
                  ? Column(
                      children: [
                        const Text('Enter minute interval for the schedule.'),
                        const SizedBox(height: 12),
                        Center(
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width * 0.48,
                            child: TextField(
                              controller: minuteInterval,
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              decoration: InputDecoration(
                                fillColor: Colors.blueGrey[100],
                                filled: true,
                                enabledBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                                focusedBorder: const UnderlineInputBorder(
                                    borderSide: BorderSide.none),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  : const SizedBox(),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: () async {
                  final localTask = Task(
                    id: task != null ? task!.id : identifier.text,
                    title: title.text,
                    description: description.text,
                    datePicked: task != null
                        ? task!.datePicked
                        : scheduleWithMinute.value
                            ? TZDateTime.now(local)
                            : dateTimePicked.value,
                    taskNotty: scheduleWithMinute.value
                        ? TaskNotification(
                            // isRepeat: repeatType.value,
                            isRepeat: scheduleWithMinute.value,
                            repeatInterval:
                                //repeatType.value == RepeatType.minutesRepeat
                                //isRepeat.value
                                //    ?
                                int.parse(minuteInterval.text)
                            // : null
                            )
                        : null,
                  );
                  viewmodel.addTask(localTask);

                  Navigator.pop(context);
                  ref.refresh(tasksProvider);
                },
                style: ButtonStyle(
                  fixedSize: MaterialStateProperty.all(
                    const Size(double.maxFinite, 44),
                  ),
                ),
                child: const Text('Save'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
