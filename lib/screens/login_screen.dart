// ignore_for_file: must_be_immutable, unnecessary_null_comparison

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:todo_app/data/task_service.dart';
import 'package:todo_app/data/user_service.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/screens/tasks_screen.dart';


class LoginScreen extends StatelessWidget {
  static UserService userService = UserService();
  static TaskService taskService = TaskService();

  const LoginScreen({super.key});

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
      List<dynamic> tasks = <dynamic>[];
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
    return FlutterLogin(
      title: 'ToDo',
      onLogin: _authUser,
      onSignup: _createUser,
      onSubmitAnimationCompleted: () {
        Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => TasksScreen(userService, taskService),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }

  void getTasks() {
    print('---getTasks()');
    taskService.getTasksFromDb(userService.user!);
  }
}
