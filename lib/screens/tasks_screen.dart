// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_app/data/task_service.dart';
import 'package:todo_app/data/user_service.dart';

import 'login_screen.dart';

class TasksScreen extends StatelessWidget {
  late UserService userService;
  late TaskService taskService;

  TasksScreen(this.userService, this.taskService, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Görev Listesi'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => const LoginScreen(),
              ));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: taskService.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(taskService.tasks[index].title),
            subtitle: Text(taskService.tasks[index].description),
            trailing: Expanded(
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {

                    },
                  ),
                  Checkbox(
                    value: taskService.tasks[index].isCompleted,
                    onChanged: (value) {

                    },
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }


}