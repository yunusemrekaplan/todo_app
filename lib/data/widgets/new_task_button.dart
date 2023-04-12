// ignore_for_file: no_logic_in_create_state

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../task_service.dart';
import '../user_service.dart';

class NewTaskButton extends StatefulWidget {
  late TaskService taskService;
  late UserService userService;

  NewTaskButton({super.key, required this.userService, required this.taskService});

  @override
  State<StatefulWidget> createState() => _NewTaskButtonState(userService: userService, taskService: taskService);
}

class _NewTaskButtonState extends State {
  late TaskService taskService;
  late UserService userService;

  _NewTaskButtonState({required this.userService, required this.taskService});


  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      child: const Text("Yeni bir görev ekle"),
      onPressed: () {
        Navigator.popAndPushNamed(context, 'addTask');
      },
    );
  }
}