// ignore_for_file: must_be_immutable, no_logic_in_create_state

import 'package:flutter/material.dart';

import '../data/task_service.dart';
import '../data/user_service.dart';
import '../models/task.dart';
import '../validators/task_validation.dart';

class TaskInfoScreen extends StatefulWidget {
  late UserService userService;
  late TaskService taskService;
  late Task task;

  TaskInfoScreen({super.key, required this.userService, required this.taskService, required this.task});

  @override
  State<StatefulWidget> createState() => _TaskInfoScreen(userService: userService, taskService: taskService, task: task);

}

class _TaskInfoScreen extends State with TaskValidation {
  late UserService userService;
  late TaskService taskService;
  late Task task;

  _TaskInfoScreen({required this.userService, required this.taskService, required this.task});

  DateTime createDate = DateTime.now();

  String subtitle = '';


  late TextEditingController _editingController;
  late FocusNode _focusNode;
  bool _isEditingText = false;
  String initialText = "Bulaşıkları Yıka";

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _editingController = TextEditingController(text: initialText);
  }

  @override
  void dispose() {
    _focusNode.dispose();
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    task.updateDate = DateTime.now();
    if(task.updateDate != null) {
      subtitle = 'Güncelleme tarihi: ${task.updateDate!.day}/${task.updateDate!.month}/${task.updateDate!.year}';
    }
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: _isEditingText
            ? TextField(
          focusNode: _focusNode,
          autofocus: true,
          controller: _editingController,
          textInputAction: TextInputAction.done,
          onSubmitted: (value) {
            setState(() {
              initialText = value;
              _isEditingText = false;
            });
          },
        )
            : Text(initialText),
        actions: [
          IconButton(
            icon: Icon(Icons.edit),
            onPressed: () {
              setState(() {
                _isEditingText = true;
              });
            },
          ),
        ],
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_outlined),
          onPressed: () {
            Navigator.popAndPushNamed(context, 'tasks');
          },
        ),
      ),
      backgroundColor: Colors.white,
      body: buildPage(),
    );
  }

  Column buildPage() {
    return Column(
      children: [
        buildCreateDateWidget(),
        const SizedBox(
          height: 15.0,
        ),
        buildTaskText(),
      ],
    );
  }

  Padding buildCreateDateWidget() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueGrey),
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.blueGrey,
        ),
        child: Card(
          color: Colors.blueGrey,
          child: Text('${createDate.day}/${createDate.month}/${createDate.year}', style: TextStyle(color: Colors.white, fontSize: (MediaQuery.of(context).size.width / 25)),),
        ),
      ),
    );
  }

  ListTile buildTaskText() {
    return ListTile(
      minLeadingWidth: (MediaQuery.of(context).size.width / 20),
      title: Text('Evden çıkmadan önce bulaşıkları yıka', style: TextStyle(fontSize: (MediaQuery.of(context).size.width / 20), color: Colors.black),),
      subtitle: Text(subtitle, style: TextStyle(fontSize: (MediaQuery.of(context).size.width / 30))),
    );
  }

}