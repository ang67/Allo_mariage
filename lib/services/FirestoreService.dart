import 'package:allo_mariage/models/event.dart';
import 'package:allo_mariage/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirestoreService {
  // Collection reference
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference _eventCollectionRef =
      FirebaseFirestore.instance.collection('events');

  Future updateUserData(User user) async {
    var option = SetOptions(merge: true);
    try {
      await _userCollectionRef.doc(user.id).set(user.toJson(), option);
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future updateEventData(Event event) async {
    var option = SetOptions(merge: true);
    try {
      await _eventCollectionRef.doc(event.eventId).set(event.toJson(), option);
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
