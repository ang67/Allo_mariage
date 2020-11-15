import 'package:allo_mariage/utils/ui_constantes.dart';
import 'package:flutter/material.dart';

class Publishing extends StatefulWidget {
  @override
  _MyEventPageState createState() => _MyEventPageState();
}

class _MyEventPageState extends State<Publishing> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('   $APP_NAME'),
        ),
        body: Center(child: Icon(Icons.add_to_home_screen_outlined)));
  }
}
