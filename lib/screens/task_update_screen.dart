// ignore_for_file: no_logic_in_create_state

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/task_service.dart';
import '../data/user_service.dart';

class TaskUpdateScreen extends StatefulWidget {
  late UserService userService;
  late TaskService taskService;

  TaskUpdateScreen({super.key, required this.userService, required this.taskService});
  @override
  State<StatefulWidget> createState() => _TaskUpdateScreen(userService: userService, taskService: taskService);

}

class _TaskUpdateScreen extends State {
  late UserService userService;
  late TaskService taskService;

  _TaskUpdateScreen({required this.userService, required this.taskService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulaşıkları Yıka'),
      ),
    );
  }
}

/*
TextFormField(
        decoration: InputDecoration(
          icon: Icon(Icons.title),
          labelText: task.title,
        ),
        controller: TextEditingController(),
        validator: titleAndSubtitleValid,

      ), */