import 'package:allo_mariage/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Collection reference
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(User user) async {
    try {
      print("########################");
      await _userCollectionRef.doc(user.id).set(user.toJson());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future getUser(String uid) async {
    try {
      var userData = await _userCollectionRef.doc(uid).get();
      return User.fromJson(userData.data());
    } catch (e) {
      return e.message;
    }
  }
}
