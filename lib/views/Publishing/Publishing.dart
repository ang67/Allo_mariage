import 'package:allo_mariage/utils/ui_constantes.dart';
import 'package:allo_mariage/views/auth/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Publishing extends StatefulWidget {
  @override
  _MyEventPageState createState() => _MyEventPageState();
}

class _MyEventPageState extends State<Publishing> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser == null) {
      return Authenticate(signIn: true);
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text('   $APP_NAME'),
          ),
          body: Center(child: Icon(Icons.add_to_home_screen_outlined)));
    }
  }
}
