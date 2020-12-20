import 'package:allo_mariage/services/FirestoreService.dart';
import 'package:allo_mariage/models/user.dart' as models;
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
    await _facebookAuth.logOut();
    await _googleSignIn.signOut();
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
      _firestoreService.updateUserData(models.User(
          id: result.user.uid,
          name: name,
          telephone: telephone,
          email: email,
          role: role));
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
      await _populateCurrentUser(fireBaseUser);
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
      firstTime
          ? _firestoreService.updateUserData(models.User(
              id: user.uid,
              name: user.displayName,
              email: user.email,
              telephone: user.phoneNumber,
              role: 'Invité'))
          : print('nonononon');

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
      bool firstTime = now.compareTo(user.metadata.creationTime) < 0;
      firstTime
          ? _firestoreService.updateUserData(models.User(
              id: user.uid,
              name: user.displayName,
              email: user.email,
              telephone: user.phoneNumber,
              role: 'Invité'))
          : print('');
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
