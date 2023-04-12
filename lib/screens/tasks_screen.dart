// ignore_for_file: must_be_immutable, avoid_web_libraries_in_flutter, no_logic_in_create_state

import'package:flutter/material.dart';
import 'package:todo_app/data/task_service.dart';
import 'package:todo_app/data/user_service.dart';
import '../widgets/task_screen_column.dart';
import 'login_screen.dart';


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
        actions: <Widget>[
          buildBackButton(),
        ],
      ),
      body: TaskScreenColumn(taskService: taskService, userService: userService,),
    );
  }


  IconButton buildBackButton() {
    return IconButton(
      icon: const Icon(Icons.exit_to_app),
      onPressed: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => LoginScreen(userService: UserService(), taskService: TaskService()),
        ));
      },
    );
  }

}