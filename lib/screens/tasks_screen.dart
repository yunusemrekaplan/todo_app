// ignore_for_file: must_be_immutable, avoid_web_libraries_in_flutter

import 'package:flutter/material.dart';
import 'package:todo_app/data/task_service.dart';
import 'package:todo_app/data/user_service.dart';

import 'login_screen.dart';

Map<String, dynamic> tasks = {
  'title' : 'Görev Başlığı',
  'description' : 'Görev açıklaması',
  'isCompleted' : false,
};

class TasksScreen extends StatelessWidget {
  late UserService userService;
  late TaskService taskService;

  TasksScreen({super.key, required this.userService, required this.taskService});

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
                builder: (context) => LoginScreen(userService: UserService(), taskService: TaskService()),
              ));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: 1,//taskService.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              buildTaskRows(context, index),
              buildNewTaskRow(context),
            ],
          );
        },
      ),
    );
  }

  ListTile buildTaskRows(BuildContext context,int index) {
    return ListTile(
      title: Text(tasks['title']),//Text(taskService.tasks[index].title),
      subtitle: Text(tasks['description']),//Text(taskService.tasks[index].description),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {

            },
          ),
          Checkbox(
            value: tasks['isCompleted'],//taskService.tasks[index].isCompleted,
            onChanged: (value) {

            },
          ),
        ],
      ),
      onTap: () {
        Navigator.pushNamed(context, 'taskInfo');
      },
    );
  }

  ElevatedButton buildNewTaskRow(BuildContext context) {
    return ElevatedButton(
      child: const Text("Yeni bir görev ekle"),
      onPressed: () {
        Navigator.popAndPushNamed(context, 'addTask');
      },
    );
  }


}