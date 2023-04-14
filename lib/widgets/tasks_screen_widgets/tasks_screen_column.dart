// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:flutter/cupertino.dart';
import 'package:todo_app/data/task_service.dart';
import 'package:todo_app/widgets/tasks_screen_widgets/tasks_screen_task_rows.dart';

import '../../data/user_service.dart';
import '../../models/task.dart';
import 'tasks_screen_new_task_button.dart';

class TasksScreenColumn extends StatefulWidget {
  late TaskService taskService;
  late UserService userService;

  TasksScreenColumn({super.key, required this.taskService, required this.userService});

  @override
  State<StatefulWidget> createState() => _TasksScreenColumnState(taskService: taskService, userService: userService);
}

class _TasksScreenColumnState extends State {
  late TaskService taskService;
  late UserService userService;

  _TasksScreenColumnState({required this.taskService, required this.userService});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TasksScreenTaskRows(userService: userService, taskService: taskService),
        NewTaskButton(userService: userService, taskService: taskService),
      ],
    );
  }
}