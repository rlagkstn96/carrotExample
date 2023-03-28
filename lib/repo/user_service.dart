import 'package:carrotexample/constants/data_keys.dart';
import 'package:carrotexample/data/user_model.dart';
import 'package:carrotexample/utils/logger.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

class UserService {
  static final UserService _userService = UserService._internal();
  factory UserService() => _userService;
  UserService._internal();

  Future createNewUser(Map<String, dynamic> json, String userKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot =
        await documentReference.get();

    if(!documentSnapshot.exists){
      await documentReference.set(json);
    }
  }

  Future<UserModel> getUserModel(String userKey) async {
    DocumentReference<Map<String, dynamic>> documentReference =
        FirebaseFirestore.instance.collection(COL_USERS).doc(userKey);
    final DocumentSnapshot<Map<String, dynamic>> documentSnapshot = await documentReference.get();
    UserModel userModel = UserModel.fromSnapshot(documentSnapshot);
    return userModel;
  }

  Future firestoreTest() async {
    FirebaseFirestore.instance
        .collection('TESTING_COLLECTION')
        .add({'testing': 'testing value', 'number': 123123});
  }

  Future firestoreReadTest() async {
    FirebaseFirestore.instance
        .collection('TESTING_COLLECTION')
        .doc('1sTGn6m1YhYiTYVpF6CY')
        .get()
        .then((DocumentSnapshot<Map<String, dynamic>> value) =>
            logger.d(value.data()));
  }
}
