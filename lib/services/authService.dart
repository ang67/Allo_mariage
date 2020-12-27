import 'package:allo_mariage/services/FirestoreService.dart';
import 'package:allo_mariage/models/user.dart' as models;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FacebookAuth _facebookAuth = FacebookAuth.instance;
  final FirestoreService _firestoreService = FirestoreService();
  models.User _currentUser;

  models.User get currentUser {
    return this._currentUser;
  }

  Future _populateCurrentUser(User user) async {
    print('ffff');
    if (user != null) {
      this._currentUser = models.User.fromJson(
          (await _firestoreService.getUser(user.uid)).data());
    }
  }

  /// Changed to idTokenChanges as it updates depending on more cases.
  Stream<User> get authStateChanges => _firebaseAuth.authStateChanges();

  // SignOut
  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _facebookAuth.logOut();
    await _firebaseAuth.signOut();
  }

  //Register with email and password
  Future<String> signUp(
      {String name,
      String email,
      String password,
      String telephone,
      String role}) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      User fireBaseUser = result.user;
      _firestoreService.setUserData(models.User(
          id: result.user.uid,
          name: name,
          telephone: telephone,
          email: email,
          role: role,
          photoURL: null,
          lastSignInTime: DateTime.now(),
          creationTime: DateTime.now()));
      await _populateCurrentUser(fireBaseUser);
      return "Signed up";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> signIn({String email, String password}) async {
    try {
      UserCredential result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      User fireBaseUser = result.user;

      //await _populateCurrentUser(fireBaseUser);
      _firestoreService.getUser(fireBaseUser.uid).then((userData) {
        _firestoreService.updateUserData(models.User(
            id: userData['id'],
            name: userData['name'],
            email: userData['email'],
            telephone: userData['telephone'],
            role: userData['role'],
            photoURL: userData['photoURL'],
            lastSignInTime: DateTime.now(), //+
            creationTime: userData['creationTime'].toDate()));
      });
      return "Signed in";
    } on FirebaseAuthException catch (e) {
      print('******************');
      return e.message;
    }
  }

  // googleSignIn
  Future googleSignIn() async {
    try {
      var now = new DateTime.now();
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      var user = (await _firebaseAuth.signInWithCredential(credential)).user;
      //await _populateCurrentUser(user);//problem here ??????????????

      //if it is first time
      bool firstTime = now.compareTo(user.metadata.creationTime) < 0;

      if (firstTime) {
        _firestoreService.setUserData(models.User(
            id: user.uid,
            name: user.displayName,
            email: user.email,
            telephone: user.phoneNumber,
            role: 'Invité',
            photoURL: user.photoURL,
            lastSignInTime: user.metadata.lastSignInTime,
            creationTime: user.metadata.creationTime));
      } else {
        _firestoreService.getUser(user.uid).then((userData) {
          _firestoreService.updateUserData(models.User(
              id: userData['id'],
              name: userData['name'],
              email: userData['email'],
              telephone: userData['telephone'],
              role: userData['role'],
              photoURL: userData['photoURL'],
              lastSignInTime: DateTime.now(), //+
              creationTime: user.metadata.creationTime));
        });
      }

      // _firestoreService.updateUserData(models.User(
      //   id: user.uid, lastSignInTime: user.metadata.lastSignInTime))

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future facebookLogIn() async {
    try {
      var now = new DateTime.now();
      // Trigger the sign-in flow
      AccessToken accessToken = await _facebookAuth.login();

      // Create a credential from the access token
      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.token);

      // Once signed in, return the UserCredential
      var user =
          (await _firebaseAuth.signInWithCredential(facebookAuthCredential))
              .user;
      //await _populateCurrentUser(user);
      //if it is first time
      print(user);
      bool firstTime = now.compareTo(user.metadata.creationTime) < 0;
      if (firstTime) {
        _firestoreService.setUserData(models.User(
            id: user.uid,
            name: user.displayName,
            email: user.email,
            telephone: user.phoneNumber,
            role: 'Invité',
            photoURL: user.photoURL,
            lastSignInTime: user.metadata.lastSignInTime,
            creationTime: user.metadata.creationTime));
      } else {
        _firestoreService.getUser(user.uid).then((userData) {
          _firestoreService.updateUserData(models.User(
              id: userData['id'],
              name: userData['name'],
              email: userData['email'],
              telephone: userData['telephone'],
              role: userData['role'],
              photoURL: userData['photoURL'],
              lastSignInTime: DateTime.now(), //+
              creationTime: user.metadata.creationTime));
        });
      }

      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
