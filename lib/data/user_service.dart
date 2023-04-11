import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserService {
  static late User user;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final UserService _singleton = UserService._internal();

  factory UserService() {
    return _singleton;
  }

  UserService._internal();

  static User getUser() {
    return UserService.user;
  }

  static void getUserFromDb(String email) async {
    await _firestore.collection('users').get().then((querySnapshot) {
      for(var doc in querySnapshot.docs) {
        print('id: ${doc.id}');
        print('reference: ${doc.reference}');
        if(doc['email'] == email) {
          UserService.user = User.fromFirestore(doc);
        }
      }
    });
  }
  
  static void addUserDb(User user) async {
    await _firestore.collection('users').add(user.mapUser());
  }
}