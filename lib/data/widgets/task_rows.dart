// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:todo_app/data/task_service.dart';
import 'package:todo_app/data/user_service.dart';

class TaskRows extends StatefulWidget {
  late TaskService taskService;
  late UserService userService;

  late int index;

  TaskRows({super.key, required this.taskService, required this.userService, required this.index});

  @override
  State<StatefulWidget> createState() => _TaskRowsState(taskService: taskService, userService: userService, index: index);

}

class _TaskRowsState extends State {
  late TaskService taskService;
  late UserService userService;

  late int index;

  _TaskRowsState({required this.taskService, required this.userService, required this.index});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(taskService.tasks![index].title),//Text(taskService.tasks[index].title),
      subtitle: Text(taskService.tasks![index].description),//Text(taskService.tasks[index].description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              setState(() {
                taskService.deleteTask(userService.user!, taskService.tasks![index]);
              });
            },
          ),
          Checkbox(
            value: taskService.tasks![index].isCompleted,//taskService.tasks[index].isCompleted,
            onChanged: (value) {
              setState(() {
                taskService.tasks![index].isCompleted = taskService.tasks![index].isCompleted == true ? false : true;
                context;
              });
            },
          ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, 'taskInfo');
      },
    );
  }
}