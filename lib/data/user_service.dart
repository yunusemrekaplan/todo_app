import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/user.dart';

class UserService {
  static late User user;
  static late bool control;

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final UserService _singleton = UserService._internal();

  factory UserService() {
    return _singleton;
  }

  UserService._internal();

  static Future<User?> getUser(String email) async {
    getUserFromDb(email);
    return user;
  }
  static Future<User?> getUserFromDb(String email) async {
    await _firestore.collection('users').get().then((querySnapshot) {
      for(var doc in querySnapshot.docs) {
        print('id: ${doc.id}');
        print('reference: ${doc.reference}');
        if(doc['email'] == email) {
          UserService.user = User.fromFirestore(doc);
          print(UserService.user.email);
          UserService.control =  true;
          print(UserService.control);
          return UserService.user;
        }
      }
    });
    UserService.control = false;
    return null;

  }
  
  static void addUserDb(User user) async {
    await _firestore.collection('users').add(user.mapUser());
  }
}