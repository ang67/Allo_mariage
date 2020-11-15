import 'package:allo_mariage/services/authService.dart';
import 'package:allo_mariage/utils/ui_constantes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  @override
  _MyAccountPageState createState() => _MyAccountPageState();
}

class _MyAccountPageState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('   $APP_NAME'),
        ),
        body: Center(
            child: FlatButton(
          onPressed: () {
            context.read<AuthService>().signOut();
          },
          child: Text('SignOut'),
        )));
  }
}