import 'package:allo_mariage/utils/ui_constantes.dart';
import 'package:allo_mariage/views/auth/signIn.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:provider/provider.dart';

class MyEvents extends StatefulWidget {
  @override
  _MyEventPageState createState() => _MyEventPageState();
}

class _MyEventPageState extends State<MyEvents> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser == null) {
      setState(() {
        loading = true;
      });
      return SignIn();
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text('   $APP_NAME'),
          ),
          body: Center(child: Icon(Icons.event)));
    }
  }
}
