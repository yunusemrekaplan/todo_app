import 'package:cloud_firestore/cloud_firestore.dart';

class Task {
  late DocumentReference id;
  late String title;
  late String description;
  late Timestamp createDate;
  late Timestamp? updateDate;
  late bool isCompleted;
  late DocumentReference? userRef;

  Task({required this.title, required this.description, this.isCompleted = false, required this.userRef});

  Task.fromFirestore(DocumentSnapshot snapshot) {
    Map? data = snapshot.data() as Map?;

    assert(data!['title'] != null);
    assert(data!['description'] != null);
    assert(data!['isCompleted'] != null);
    assert(data!['userRef'] != null);
    assert(data!['createDate'] != null);

    id = snapshot.reference;
    title = data!['title'];
    description = data['description'];
    createDate = data['createDate'];
    updateDate = data['updateDate'];
    isCompleted = data['isCompleted'];
    userRef = data['userRef'];
  }

  Map<String, dynamic> mapTask() {
    return {
      'title' : title,
      'description' : description,
      'isCompleted' : isCompleted,
      'createData' : createDate,
      'updateData' : null,
      'userRef' : userRef,
    };
  }

}