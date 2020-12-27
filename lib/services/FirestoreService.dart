import 'package:allo_mariage/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Collection reference
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');

  Future updateUserData(User user) async {
    try {
      await _userCollectionRef.doc(user.id).update(user.toJson());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future setUserData(User user) async {
    try {
      await _userCollectionRef.doc(user.id).set(user.toJson());
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<DocumentSnapshot> getUser(String uid) async {
    try {
      var a;
      await _userCollectionRef
          .doc(uid)
          .get()
          .then((DocumentSnapshot documentSnapshot) {
        if (documentSnapshot.exists) {
          //print('Document data: ${documentSnapshot.data()}');
          a = documentSnapshot;
          //print(a);
        } else {
          print('Document does not exist on the database');
        }
      });
      return a;
    } catch (e) {
      print(e.message);
      return e.message;
    }
  }
}
