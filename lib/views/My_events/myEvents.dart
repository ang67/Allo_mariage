import 'package:allo_mariage/utils/ui_constantes.dart';
import 'package:flutter/material.dart';

class MyEvents extends StatefulWidget {
  @override
  _MyEventPageState createState() => _MyEventPageState();
}

class _MyEventPageState extends State<MyEvents> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('   $APP_NAME'),
        ),
        body: Center(child: Icon(Icons.event)));
  }
}
