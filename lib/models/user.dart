import 'package:cloud_firestore/cloud_firestore.dart';

class User {
  late DocumentReference id;
  late String email;
  late String password;
  late List<dynamic> tasks;

  User({required this.email, required this.password, required this.tasks});

  User.fromFirestore(DocumentSnapshot snapshot) {
    Map? data = snapshot.data() as Map?;

    assert(data!['email'] != null);
    assert(data!['password'] != null);
    assert(data!['tasks'] != null);

    id = snapshot.reference;
    email = data!['email'];
    password = data['password'];
    tasks = data['tasks'];
  }


  Map<String, dynamic> mapUser() {
    return {
      'email' : email,
      'password': password,
      'tasks' : tasks,
    };
  }
}