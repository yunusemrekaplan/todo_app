// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';
import 'package:todo_app/screens/tasks_screen.dart';
import 'package:todo_app/widgets/task_info_screen_widgets/task_info_screen_created_date_widget.dart';
import 'package:todo_app/widgets/task_info_screen_widgets/task_info_screen_task_text.dart';

import '../data/task_service.dart';
import '../data/user_service.dart';
import '../models/task.dart';
import '../validators/task_validation.dart';

class TaskInfoScreen extends StatefulWidget {
  late UserService userService;
  late TaskService taskService;
  late Task? task;

  TaskInfoScreen(
      {super.key,
      required this.userService,
      required this.taskService,
      required this.task});

  @override
  State<StatefulWidget> createState() => _TaskInfoScreen(
      userService: userService, taskService: taskService, task: task!);
}

class _TaskInfoScreen extends State with TaskValidation {
  late UserService userService;
  late TaskService taskService;
  late Task task;

  _TaskInfoScreen(
      {required this.userService,
      required this.taskService,
      required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          task.title.toUpperCase(),
          style: const TextStyle(color: Colors.white),
        ),
        actions: [
          IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(task.title),
                        content: const Text('Görevi silmek mi istiyorsunuz?'),
                        actions: [
                          TextButton(
                            child: const Text('Evet'),
                            onPressed: () {
                                deleteTask(task);
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                            TasksScreen(
                                              userService: userService,
                                              taskService: taskService,
                                            )));

                            },
                          ),
                          TextButton(
                            child: const Text('Hayır'),
                            onPressed: () {
                              Navigator.pop(context);
                            },
                          ),
                        ],
                      );
                    });
              }),
          /*IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {},
          ),*/
        ],
      ),
      backgroundColor: Colors.white,
      body: buildPage(),
    );
  }

  Column buildPage() {
    return Column(
      children: [
        TaskInfoScreenCreatedDateWidget(
          task: task,
        ),
        const SizedBox(
          height: 15.0,
        ),
        TaskInfoScreenTaskText(
          task: task,
        ),
      ],
    );
  }

  void deleteTask(Task task) async {
    userService.removeTask(task);
    taskService.deleteTask(task);
  }
}
