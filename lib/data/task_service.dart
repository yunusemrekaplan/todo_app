import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';
import '../models/user.dart';

class TaskService {
  static late List<Task> tasks;
  late Task task;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final TaskService _singleton = TaskService._internal();

  factory TaskService() {
    return _singleton;
  }

  TaskService._internal();

  static List<Task> getTasks() {
    return TaskService.tasks;
  }

  static void getTasksFromDb(User user) async {
    await _firestore.collection('tasks').get().then((querySnapshot) {
      for(var doc in querySnapshot.docs) {
        if(user.dbTasks.contains(doc.reference)) {
          user.tasks.add(Task.fromFirestore(doc));
        }
      }
    });
  }
  
  static void addTask(Task task) async {
    await _firestore.collection('task').add(task.mapTask());
  }
}