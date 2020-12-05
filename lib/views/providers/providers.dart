import 'package:allo_mariage/views/auth/authenticate.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Providers extends StatefulWidget {
  @override
  _ProvidersState createState() => _ProvidersState();
}

class _ProvidersState extends State<Providers> {
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser == null) {
      setState(() {
        loading = true;
      });
      return Authenticate(signIn: true);
    } else {
      return Scaffold(
          appBar: AppBar(
            title: Text('Prestataires de Mariage'),
          ),
          body: Center(child: Icon(Icons.event)));
    }
  }
}
