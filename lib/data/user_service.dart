import 'dart:core';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';
import '../models/user.dart';

class UserService {
  late User? user;
  late bool control;
  List<Task> tasks= <Task>[];
  int length = 0;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final UserService _singleton = UserService._internal();

  factory UserService() {
    return _singleton;
  }

  UserService._internal();

  Future<User?> getUser(String email) async {
    await getUserFromDb(email);
    return user;
  }

  Future<void> getUserFromDb(String email) async {
    control = false;
    await _firestore.collection('users').get().then((querySnapshot) {
      for(var doc in querySnapshot.docs) {
        if(doc['email'] == email) {
          user = User.fromFirestore(doc);
          control =  true;
        }
      }
    });
    return;
  }

  void addUserDb(User user) async {
    DocumentReference userRef = await _firestore.collection('users').add(user.mapUser());
    await _firestore.collection('users').get().then((value) {
      for(var doc in value.docs) {
        if(doc.reference == userRef) {
          user = User.fromFirestore(doc);
          this.user = user;
          break;
        }
      }
    });

  }

  void setTasks(List<Task>? tasks) {
    this.tasks = tasks!;
    length = tasks.length;
  }

  List<Task>? getTask() {
    return tasks;
  }

  void removeTask(Task task) async {
    print('başlık: ${task.title}');
    DocumentReference id = task.id;
    tasks.remove(task);
    user!.tasks.remove(id);
    await _firestore.collection('users').doc(user!.id.id).update({'tasks': user!.tasks});
  }

  void addTask(Task task) {
    tasks.add(task);
  }
}