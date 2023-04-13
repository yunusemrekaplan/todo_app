// ignore_for_file: must_be_immutable, avoid_web_libraries_in_flutter, no_logic_in_create_state

import'package:flutter/material.dart';
import 'package:todo_app/data/task_service.dart';
import 'package:todo_app/data/user_service.dart';
import 'package:todo_app/widgets/tasks_screen_widgets/tasks_screen_back_button.dart';
import '../widgets/tasks_screen_widgets/tasks_screen_column.dart';


class TasksScreen extends StatefulWidget {
  late UserService userService;
  late TaskService taskService;

  TasksScreen({super.key, required this.userService, required this.taskService});

  @override
  State<StatefulWidget> createState() => _TasksScreenState(userService: userService, taskService: taskService);

}

class _TasksScreenState extends State {
  late UserService userService;
  late TaskService taskService;

  _TasksScreenState({required this.userService, required this.taskService});

  @override
  Widget build(BuildContext context) {
    //double screenHeight = (MediaQuery.of(context).size.height);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Görev Listesi'),
        automaticallyImplyLeading: false,
        actions: const <Widget>[
          TasksScreenBackButton(),
        ],
      ),
      body: TasksScreenColumn(taskService: taskService, userService: userService,),
    );
  }


}