
// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/data/task_service.dart';
import 'package:todo_app/data/user_service.dart';
import 'package:todo_app/screens/tasks_screen.dart';
import 'package:todo_app/validators/task_validation.dart';

import '../models/task.dart';

class AddNewTaskScreen extends StatefulWidget {
  late UserService userService;
  late TaskService taskService;

  AddNewTaskScreen(
      {super.key, required this.userService, required this.taskService});

  @override
  State<StatefulWidget> createState() => _AddNewTaskScreen(userService: userService, taskService: taskService);
}

class _AddNewTaskScreen extends State with TaskValidation {
  late UserService userService;
  late TaskService taskService;
  String title = '';
  String description = '';
  late Timestamp createDate;

  _AddNewTaskScreen({required this.userService, required this.taskService});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Görev ekle"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: buildFrom(context),
    );
  }

  Padding buildFrom(BuildContext context) {
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

  Row buildDescriptionTextField() {
    return Row(
      //mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: 120,
          padding: const EdgeInsets.only(top: 5),
          child: const Text(
            'Açıklama: ',
            style: TextStyle(fontSize: 22.0),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: TextFormField(
            validator: titleAndSubtitleValid,
            maxLines: 100,
            decoration: const InputDecoration(
              hintText: 'Enter your name',
              border: OutlineInputBorder(),
            ),
            onChanged: (value) {
              description = value.toString();

            },
          ),
        ),
      ],
    );
  }

  ElevatedButton buildSaveButton(BuildContext context) {
    return ElevatedButton(
      child: const Text('Kaydet'),
      onPressed: () {
        //TODO showalert kullanarak title ve description değişkenlerini kontrol et.
        print('tıklandı');
        if(title == '' || description == '') {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Lütfen başlık ve açıklama bölümlerini boş bırakmayınız!!!'),
                actions: [
                  TextButton(onPressed: () => Navigator.pop(context), child: const Text('Tamam')),
                ],
              );
            }
          );
        }
        else {
          createDate = Timestamp.fromDate(DateTime.now());
          Task task = Task(title: title, description: description, createDate: createDate, userRef: userService.user!.id);
          userService.addTask(task);
          taskService.addTask(userService.user!, task, userService.tasks);
          /*userService.setTasks(taskService.tasks);*/
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (BuildContext context) =>
                      TasksScreen(
                        userService: userService,
                        taskService: taskService,
                      )));
        }
      },
    );
  }
}
