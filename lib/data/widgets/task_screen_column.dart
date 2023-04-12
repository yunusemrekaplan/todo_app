// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:flutter/cupertino.dart';
import 'package:todo_app/data/task_service.dart';
import 'package:todo_app/data/widgets/new_task_button.dart';
import 'package:todo_app/data/widgets/task_rows.dart';

import '../user_service.dart';

class TaskScreenColumn extends StatefulWidget {
  late TaskService taskService;
  late UserService userService;

  TaskScreenColumn({super.key, required this.taskService, required this.userService});

  @override
  State<StatefulWidget> createState() => _TaskScreenColumnState(taskService: taskService, userService: userService);
}

class _TaskScreenColumnState extends State {
  late TaskService taskService;
  late UserService userService;

  _TaskScreenColumnState({required this.taskService, required this.userService});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildTaskRows(),
        NewTaskButton(userService: userService, taskService: taskService),
      ],
    );
  }

  SizedBox buildTaskRows() {
    return SizedBox(
      height: ((taskService.tasks!.length + 1) * 48 + 10),
      child: ListView.builder(
        itemCount: taskService.tasks!.length,
        itemBuilder: (BuildContext context, int index) {
          return TaskRows(taskService: taskService, userService: userService, index: index);
        },
      ),
    );
  }
}