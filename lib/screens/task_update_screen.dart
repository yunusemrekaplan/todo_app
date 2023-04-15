// ignore_for_file: no_logic_in_create_state, must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/validators/task_validation.dart';

import '../data/task_service.dart';
import '../data/user_service.dart';
import '../models/task.dart';

class TaskUpdateScreen extends StatefulWidget {
  late UserService userService;
  late TaskService taskService;
  late Task? task;

  TaskUpdateScreen({super.key, required this.userService, required this.taskService, required this.task});
  @override
  State<StatefulWidget> createState() => _TaskUpdateScreen(userService: userService, taskService: taskService, task: task!);

}

class _TaskUpdateScreen extends State with TaskValidation{
  late UserService userService;
  late TaskService taskService;
  late Task task;
  late String title;
  late String description;
  late Timestamp updateDate;

  _TaskUpdateScreen({required this.userService, required this.taskService, required this.task});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bulaşıkları Yıka'),
      ),
      body: buildForm(context),
    );
  }

  Padding buildForm(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          child: buildTextFields(context),
        )
    );
  }

  Column buildTextFields(BuildContext context) {
    return Column(
      children: [
        buildTitleTextField(),
        const SizedBox(
          height: 40,
        ),
        SizedBox(
          height: 130,
          child: buildDescriptionTextField(),
        ),
        const SizedBox(
          height: 50,
        ),
        buildSaveButton(context)
      ],
    );
  }

  Row buildTitleTextField() {
    return Row(
      children: [
        const Text(
          'Başlık: ',
          style: TextStyle(fontSize: 22.0),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            validator: titleAndSubtitleValid,
            decoration: const InputDecoration(
              hintText: 'Başlık giriniz',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              title = value.toString();
            },
          ),
        ),
      ],
    );
  }

  buildDescriptionTextField() {}

  buildSaveButton(BuildContext context) {}
}