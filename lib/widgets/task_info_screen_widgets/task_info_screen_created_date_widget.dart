// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';

import '../../models/task.dart';

class TaskInfoScreenCreatedDateWidget extends StatelessWidget {
  late Task task;

  TaskInfoScreenCreatedDateWidget({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueGrey),
            borderRadius: BorderRadius.circular(15.0),
            color: Colors.blueGrey,
          ),
          child: Card(
            color: Colors.blueGrey,
            child: Text('${task.createDate.toDate().day}/${task.createDate.toDate().month}/${task.createDate.toDate().year}', style: TextStyle(color: Colors.white, fontSize: (MediaQuery.of(context).size.width / 25)),),
          ),
        ),
      ),
    );
  }
}