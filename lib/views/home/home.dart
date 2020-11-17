import 'package:allo_mariage/utils/ui_constantes.dart';
import 'package:allo_mariage/views/widgets/search/search_field.dart';
import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(APP_NAME),
      ),
      body: ListView(children: <Widget>[
        Container(
            child: Column(children: <Widget>[
          SizedBox(height: 30),
          SearchField(),
        ]))
      ]),
    );
  }
}
