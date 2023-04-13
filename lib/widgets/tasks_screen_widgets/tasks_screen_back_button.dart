import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/task_service.dart';
import '../../data/user_service.dart';
import '../../screens/login_screen.dart';

class TasksScreenBackButton extends StatelessWidget {
  const TasksScreenBackButton({super.key});

  @override
  Widget build(BuildContext context) {
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