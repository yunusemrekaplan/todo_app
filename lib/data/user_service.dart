import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/task.dart';
import '../models/user.dart';

class UserService {
  late User? user;
  late bool control;
  late List<Task>? tasks;
  late int length;

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
    await _firestore.collection('users').add(user.mapUser());
  }

  void setTasks(List<Task>? tasks) {
    this.tasks = tasks;
    length = tasks!.length;
  }
}