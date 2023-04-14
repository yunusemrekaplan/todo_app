// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:todo_app/data/task_service.dart';
import 'package:todo_app/data/user_service.dart';
import 'package:todo_app/screens/task_info_screen.dart';

import '../../models/task.dart';

class TasksScreenTaskRow extends StatefulWidget {
  late TaskService taskService;
  late UserService userService;
  late int index;

  TasksScreenTaskRow({super.key, required this.taskService, required this.userService, required this.index});

  @override
  State<StatefulWidget> createState() => _TasksScreenTaskRowState(taskService: taskService, userService: userService, index: index);

}

class _TasksScreenTaskRowState extends State {
  late TaskService taskService;
  late UserService userService;
  late int index;

  _TasksScreenTaskRowState({required this.taskService, required this.userService, required this.index});

  @override
  Widget build(BuildContext context) {

    return ListTile(
      title: Text(userService.tasks![index].title),//Text(taskService.tasks[index].title),
      subtitle: Text(userService.tasks![index].description),//Text(taskService.tasks[index].description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Checkbox(
            value: userService.tasks![index].isCompleted,//taskService.tasks[index].isCompleted,
            onChanged: (value) {
              setState(() {
                userService.tasks![index].isCompleted = userService.tasks![index].isCompleted == true ? false : true;
                taskService.updateTask(taskService.tasks![index]);
              });
            },
          ),
        ],
      ),
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (BuildContext context) => TaskInfoScreen(userService: userService, taskService: taskService, task: userService.tasks![index],)));
      },
    );
  }
}