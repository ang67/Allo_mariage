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
  //models.User _currentUser;

  // Future<models.User> currentUser(String uid) async {
  //   return await _firestoreService.getUser(uid);
  // }

  // Future _populateCurrentUser(User user) async {
  //   if (user != null) {
  //     _currentUser = await _firestoreService.getUser(user.uid);
  //   }
  // }

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
      print(""" $name,
      $email,
        $password,
        $telephone,
        $role
       """);
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      //User fireBaseUser = result.user;
      _firestoreService.updateUserData(models.User(
          id: result.user.uid,
          name: name,
          telephone: telephone,
          email: email,
          role: role));
      //await _populateCurrentUser(fireBaseUser);
      return "Signed up";
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<String> signIn({String email, String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
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

      //if it is first time
      bool firstTime = now.compareTo(user.metadata.creationTime) < 0;
      // print(user);
      // print('$firstTime, $now, ${user.metadata.creationTime}');
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

  // Future facebookLogIn() async {
  //   final facebookLogin = FacebookLogin();
  //   final result = await facebookLogin.logInWithReadPermissions(['email']);
  //   final FacebookLoginResult facebookLoginResult =
  //       await FacebookSignIn().logInWithReadPermissions(['email']);

  //   switch (facebookLoginResult.status) {
  //     case FacebookLoginStatus.loggedIn:
  //       // Sign the user in with the credential

  //       final FacebookAccessToken accessToken = facebookLoginResult.accessToken;
  //       FacebookAuthCredential facebookAuthCredential =
  //           FacebookAuthProvider.credential((accessToken.toString()));

  //       var result =
  //           await _firebaseAuth.signInWithCredential(facebookAuthCredential);
  //       return result.user;

  //     case FacebookLoginStatus.cancelledByUser:
  //       print('Login cancelled by the user.');
  //       break;
  //     case FacebookLoginStatus.error:
  //       print('Something went wrong with the login process.\n'
  //           'Here\'s the error Facebook gave us: ${facebookLoginResult.errorMessage}');
  //       break;
  //   }
  // }

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
      //if it is first time
      bool firstTime = now.compareTo(user.metadata.creationTime) < 0;
      // print(user);
      // print('$firstTime, $now, ${user.metadata.creationTime}');
      firstTime
          ? _firestoreService.updateUserData(models.User(
              id: user.uid,
              name: user.displayName,
              email: user.email,
              telephone: user.phoneNumber,
              role: 'Invité'))
          : print('');
      //print(user);
      return user;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
