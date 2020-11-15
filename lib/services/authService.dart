import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth;

  AuthService(this._firebaseAuth);
  GoogleSignIn _googleSignIn = GoogleSignIn();
  FacebookAuth _facebookAuth = FacebookAuth.instance;

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
      {String email, String password, String telephone, String role}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);

      return "Signed up";
    } on FirebaseAuthException catch (e) {
      return e.message;
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
      GoogleSignInAccount googleSignInAccount = await _googleSignIn.signIn();
      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
          accessToken: googleSignInAuthentication.accessToken);

      var result = (await _firebaseAuth.signInWithCredential(credential));

      return result.user;
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

  Future<UserCredential> facebookLogIn() async {
    try {
      // Trigger the sign-in flow
      AccessToken accessToken = await _facebookAuth.login();

      // Create a credential from the access token
      final FacebookAuthCredential facebookAuthCredential =
          FacebookAuthProvider.credential(accessToken.token);

      // Once signed in, return the UserCredential
      var result =
          await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      print("*/*/*/Facebook user */*/*");
      print(result);
      return result;
    } catch (e) {
      print(e.toString());
      return null;
    }
  }
}
