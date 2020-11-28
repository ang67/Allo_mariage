import 'package:allo_mariage/views/base.dart';
import 'package:flutter/material.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (BuildContext context) => BaseScreen()),
                      ModalRoute.withName('/base'));
                },
              ),
              Text('Mon compte'),
            ],
          ),
        ),
        body: Container(child: Center(child: Icon(Icons.settings))));
  }
}
