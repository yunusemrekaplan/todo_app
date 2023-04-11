import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';
import '../models/user.dart';


class TaskService {
  List<Task> tasks = <Task>[];
  late Task task;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final TaskService _singleton = TaskService._internal();

  factory TaskService() {
    return _singleton;
  }

  TaskService._internal();

  void getTasksFromDb(User user) async {
    await _firestore.collection('tasks').get().then((querySnapshot) {
      for(var doc in querySnapshot.docs) {
        print('---for');
        if(user.tasks.contains(doc.reference)) {
          print('---if');
          tasks.add(Task.fromFirestore(doc));
        }
      }
      print(tasks.length);
    });
  }
  
  void addTask(User user, Task task) async {
    await _firestore.collection('task').add(task.mapTask());
    user.tasks.add(task.id);
  }
}