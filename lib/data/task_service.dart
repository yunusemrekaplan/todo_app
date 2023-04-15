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
        if(user.tasks.contains(doc.reference)) {
          tasks!.add(Task.fromFirestore(doc));
        }
      }
    });
  }
  
  void addTask(User user, Task task, List<Task> tasksUser) async {
    try {
      DocumentReference taskRef = await _firestore.collection('tasks').add(task.mapTask());
      late DocumentSnapshot taskSnap;
      await _firestore.collection('tasks').get().then((value) {
        for(var doc in value.docs) {
          if(doc.reference == taskRef) {
            taskSnap = doc;
            break;
          }
        }
      });
      tasksUser.last = Task.fromFirestore(taskSnap);
      user.tasks.add(taskRef);
      await _firestore.collection('users').doc(user.id.id).update({'tasks': user.tasks});
      //tasks!.add(task);
    } on Exception catch (e) {
      print('addTask');
      print(e.toString());
    }
  }
  
  void deleteTask(Task task) async {
    try {
      DocumentReference id = task.id;
      tasks?.remove(task);
      await _firestore.collection('tasks').doc(id.id).delete();

    } on Exception catch (e) {
      print('4---deleteTask');
      print(e.toString());
    }
  }

  void updateTask(Task task) async {
    await _firestore.collection('tasks').doc(task.id.id).update(task.mapTask());
  }



}