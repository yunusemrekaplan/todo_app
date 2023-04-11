import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task.dart';

class User {
  late DocumentReference id;
  late String email;
  late String password;
  late List<DocumentReference> dbTasks;
  List<Task> tasks = <Task>[];

  User({required this.email, required this.password});

  User.fromFirestore(DocumentSnapshot snapshot) {
    Map? data = snapshot.data() as Map?;

    assert(data!['email'] != null);
    assert(data!['password'] != null);

    id = snapshot.reference;
    tasks = data!['tasks'];
    email = data['email'];
    password = data['password'];
  }


  Map<String, dynamic> mapUser() {
    return {
      'email' : email,
      'password': password,
      'tasks' : tasks,
    };
  }
}