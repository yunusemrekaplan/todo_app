// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../models/task.dart';

class TaskInfoScreenTaskText extends StatelessWidget {
  late Task task;

  TaskInfoScreenTaskText({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      minLeadingWidth: (MediaQuery.of(context).size.width / 20),
      title: Text(task.description.toString(), style: TextStyle(fontSize: (MediaQuery.of(context).size.width / 23), color: Colors.black),),
    );
  }

}