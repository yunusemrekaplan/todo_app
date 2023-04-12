import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/screens/add_new_task_screen.dart';
import 'package:todo_app/screens/login_screen.dart';
import 'package:todo_app/screens/task_info_screen.dart';
import 'package:todo_app/screens/task_update_screen.dart';
import 'package:todo_app/screens/tasks_screen.dart';

import 'data/task_service.dart';
import 'data/user_service.dart';
import 'firebase_options.dart';
import 'models/task.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const TodoApp());
}

class TodoApp extends StatefulWidget {
  const TodoApp({super.key});

  @override
  State<StatefulWidget> createState() => _TodoAppState();
}

class _TodoAppState extends State {
  UserService userService = UserService();
  TaskService taskService = TaskService();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToDo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      routes: {
        '/': (BuildContext context) => LoginScreen(userService: userService, taskService: taskService),
        'tasks': (BuildContext context) => TasksScreen(userService: userService, taskService: taskService),
        //'addTasks': (BuildContext context) => AddNewTaskScreen(userService: userService, taskService: taskService),
        'taskInfo': (BuildContext context) => TaskInfoScreen(userService: userService, taskService: taskService, task: Task(title: 'Bulaşıkları Yıka', description: 'Evden çıkmadan bulaşıkları yıka', userRef: null),),
        'taskUpdate': (BuildContext context) => TaskUpdateScreen(userService: userService, taskService: taskService),
      },
      initialRoute: 'tasks',
    );
  }
}