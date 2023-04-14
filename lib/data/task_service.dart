import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';
import '../models/user.dart';


class TaskService {
  List<Task>? tasks = <Task>[];

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final TaskService _singleton = TaskService._internal();

  factory TaskService() {
    return _singleton;
  }

  TaskService._internal();

  Future<void> getTasksFromDb(User user) async {
    await _firestore.collection('tasks').get().then((querySnapshot) {
      for(var doc in querySnapshot.docs) {
        print('---for');
        if(user.tasks.contains(doc.reference)) {
          print('---if');
          tasks!.add(Task.fromFirestore(doc));
        }
      }
      print(tasks!.length);
    });
  }
  
  void addTask(User user, Task task) async {
    try {
      DocumentReference taskRef = await _firestore.collection('tasks').add(task.mapTask());
      user.tasks.add(taskRef);
      await _firestore.collection('users').doc(user.id.id).update({'tasks': user.tasks});
      tasks!.add(task);
    } on Exception catch (e) {
      print('addTask');
      print(e.toString());
    }
  }
  
  void deleteTask(User user, Task task) async {
    try {
      tasks?.remove(task);
      //await _firestore.collection('tasks').doc(task.id.id).delete();
      user.tasks.remove(task.id);
      await _firestore.collection('users').doc(user.id.id).update(user.mapUser());
    } on Exception catch (e) {
      print('4---deleteTask');
      print(e.toString());
    }
  }

  void updateTask(Task task) async {
    await _firestore.collection('tasks').doc(task.id.id).update(task.mapTask());
  }



}