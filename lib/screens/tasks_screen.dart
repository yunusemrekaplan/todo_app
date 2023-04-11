// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:todo_app/data/task_service.dart';

import '../models/task.dart';
import 'login_screen.dart';

class TasksScreen extends StatelessWidget {
  late List<Task> tasks;
  TasksScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Görev Listesi'),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.exit_to_app),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (context) => LoginScreen(),
              ));
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: TaskService.tasks.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(tasks[index].title),
            subtitle: Text(tasks[index].description),
            trailing: Checkbox(
              value: true,
              onChanged: (value) {

              },
            ),
          );
        },
      ),
    );
  }
}