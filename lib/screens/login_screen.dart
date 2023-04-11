// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:todo_app/data/user_service.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/screens/tasks_screen.dart';


class LoginScreen extends StatelessWidget {
  late User user;
  LoginScreen({super.key});

  Duration get loginTime => const Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) {
    //print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) {
      UserService.getUserFromDb(data.name);
      user = UserService.getUser();
      if (UserService.control) {
        return 'Kullanıcı bulunamadı';
      }
      if (user.password != data.password) {
        return 'Şifre yanlış';
      }
      return null;
    });
  }

  Future<String?> _createUser(SignupData data) {
    print('Name: ${data.name}, Password: ${data.password}');
    return Future.delayed(loginTime).then((_) async {
      UserService.getUserFromDb(data.name!);
      user = UserService.getUser();
      if (UserService.control) {
        return 'Kullanıcı zaten var';
      }
      UserService.addUserDb(User(email: data.name!, password: data.password!));
      return null;
    });
  }

  Future<String?> _recoverPassword(String name) {
    //print('Name: $name');
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
          builder: (context) => TasksScreen(),
        ));
      },
      onRecoverPassword: _recoverPassword,
    );
  }

}
