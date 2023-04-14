// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:flutter/cupertino.dart';
import 'package:todo_app/widgets/tasks_screen_widgets/tasks_screen_task_row.dart';

import '../../data/task_service.dart';
import '../../data/user_service.dart';
import '../../models/task.dart';

class TasksScreenTaskRows extends StatefulWidget {
  late TaskService taskService;
  late UserService userService;

  TasksScreenTaskRows({super.key, required this.userService, required this.taskService});

  @override
  State<StatefulWidget> createState() => _TasksScreenTaskRowsState(userService: userService, taskService: taskService);

}

class _TasksScreenTaskRowsState extends State {
  late TaskService taskService;
  late UserService userService;

  _TasksScreenTaskRowsState({required this.userService, required this.taskService});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: ((userService.tasks!.length + 3) * 48 + 10),
      child: ListView.builder(
        itemCount: userService.tasks!.length,
        itemBuilder: (BuildContext context, int index) {
          return TasksScreenTaskRow(taskService: taskService, userService: userService, index: index,);
        },
      ),
    );
  }
}