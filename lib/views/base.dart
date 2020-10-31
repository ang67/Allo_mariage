import 'package:allo_mariage/services/authService.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BaseScreen extends StatefulWidget {
  @override
  _BaseScreenState createState() => _BaseScreenState();
}

class _BaseScreenState extends State<BaseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: FlatButton(
          onPressed: () {
            context.read<AuthService>().signOut();
          },
          child: Text('SignOut'),
        ),
      ),
    );
  }
}
