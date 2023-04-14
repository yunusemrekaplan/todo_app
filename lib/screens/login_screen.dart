// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:todo_app/data/task_service.dart';
import 'package:todo_app/data/user_service.dart';
import 'package:todo_app/models/user.dart';

import '../models/task.dart';


class LoginScreen extends StatelessWidget {
  late UserService userService;
  late TaskService taskService;

  LoginScreen({super.key, required this.userService, required this.taskService});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    bool control = true;
    return Future.delayed(loginTime).then((_) async {
      await userService.getUserFromDb(data.name);

      if (userService.control == false) {
        control = false;
        return 'Kullanıcı bulunamadı';
      }

      if (userService.user?.password != data.password) {
        control = false;
        userService.user = null;
        return 'Şifre yanlış';
      }
      if(control) {
        getTasks();
      }

      return null;
    });
  }

  Future<String?> _createUser(SignupData data) async {
    return Future.delayed(loginTime).then((_) async {
      await userService.getUserFromDb(data.name!);

      if (userService.control == true) {
        return 'Kullanıcı zaten var';
      }
      List<DocumentReference> tasks = <DocumentReference>[];
      userService.addUserDb(User(email: data.name!, password: data.password!, tasks: tasks));

      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    return Future.delayed(loginTime).then((_) {
      return "Şu anda bu hizmet verilememektedir!";
    });
  }

  @override
  Widget build(BuildContext context) {
    taskService.tasks = <Task>[];
    return FlutterLogin(
      title: 'ToDo',
      onLogin: _authUser,
      onSignup: _createUser,
      onSubmitAnimationCompleted: () {
        Navigator.pushNamed(context, 'tasks');
      },
      onRecoverPassword: _recoverPassword,
    );
  }

  void getTasks() {
    taskService.getTasksFromDb(userService.user!);
    userService.setTasks(taskService.tasks!);
  }
}
