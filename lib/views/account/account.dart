import 'package:allo_mariage/views/base.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Account extends StatefulWidget {
  @override
  _AccountState createState() => _AccountState();
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    final CollectionReference _userCollectionRef =
        FirebaseFirestore.instance.collection('users');
    final firebaseUser = context.watch<User>();
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
      body: Container(
          margin: EdgeInsets.only(top: 10),
          child: Column(
            children: [
              Container(
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.person,
                  ),
                ),
              ),
              FutureBuilder<DocumentSnapshot>(
                  future: _userCollectionRef.doc(firebaseUser.uid).get(),
                  builder: (BuildContext context,
                      AsyncSnapshot<DocumentSnapshot> snapshot) {
                    if (snapshot.hasError) {
                      return Text("Something went wrong");
                    }
                    if (snapshot.connectionState == ConnectionState.done) {
                      Map<String, dynamic> data = snapshot.data.data();
                      return Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            ListTile(
                                leading: null,
                                title: Text("Nom et prénom: ${data['name']}")),
                            ListTile(
                                leading: null,
                                title: Text("Email: ${data['email']}")),
                            ListTile(
                                leading: null,
                                title: Text("Téléphone: ${data['telephone']}")),
                            ListTile(
                                leading: null,
                                title: Text("Rôle: ${data['role']}")),
                          ]);
                    } else {
                      return CircularProgressIndicator(
                        backgroundColor: Colors.white,
                        semanticsLabel: 'Patientez',
                      );
                    }
                  }),
            ],
          )),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.edit),
      ),
    );
  }
}
