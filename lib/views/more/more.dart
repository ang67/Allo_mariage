import 'package:allo_mariage/services/FirestoreService.dart';
import 'package:allo_mariage/services/authService.dart';
import 'package:allo_mariage/views/account/account.dart';
import 'package:allo_mariage/views/auth/authenticate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class More extends StatefulWidget {
  @override
  _MoreState createState() => _MoreState();
}

class _MoreState extends State<More> {
  FirestoreService firestoreService = FirestoreService();
  final CollectionReference _userCollectionRef =
      FirebaseFirestore.instance.collection('users');
  Widget page;
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    return page ??
        Scaffold(
            body: CustomScrollView(slivers: <Widget>[
          SliverAppBar(
              elevation: 0,
              pinned: true,
              snap: false,
              floating: true,
              expandedHeight: 200.0,
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: firebaseUser == null
                    ? null
                    : FutureBuilder<DocumentSnapshot>(
                        future: _userCollectionRef.doc(firebaseUser.uid).get(),
                        builder: (BuildContext context,
                            AsyncSnapshot<DocumentSnapshot> snapshot) {
                          if (snapshot.hasError) {
                            return Text("Something went wrong");
                          }
                          if (snapshot.connectionState ==
                              ConnectionState.done) {
                            Map<String, dynamic> data = snapshot.data.data();
                            return Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  CircleAvatar(
                                    backgroundColor: Colors.white70,
                                    child: Icon(Icons.person),
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Center(
                                            child: InkWell(
                                                child: Text(data['name']),
                                                onTap: () {}))
                                        //Text("$user"),
                                        //IconButton(icon: Icon(Icons.keyboard_arrow_right, color: Colors.pink), onPressed: (){})
                                      ])
                                ]);
                          } else {
                            return CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              semanticsLabel: 'Patientez',
                            );
                          }
                        }),
                background: FlutterLogo(),
              )),
          // If the main content is a list, use SliverList instead.
          SliverFillRemaining(
              hasScrollBody: false,
              fillOverscroll: false,
              child: Center(
                  child: Container(
                      child: Column(children: <Widget>[
                ListTile(
                    leading:
                        Icon(Icons.emoji_objects_outlined, color: Colors.grey),
                    title: Text('Inspirations',
                        style: Theme.of(context).textTheme.bodyText1),
                    onTap: () => {}),
                ListTile(
                    leading: Icon(Icons.forum_outlined, color: Colors.grey),
                    title: Text('Communauté',
                        style: Theme.of(context).textTheme.bodyText1),
                    onTap: () => {}),
                ListTile(
                    leading:
                        Icon(Icons.card_giftcard_outlined, color: Colors.grey),
                    title: Text('Liste Cadeaux',
                        style: Theme.of(context).textTheme.bodyText1),
                    onTap: () => {}),
                ListTile(
                    leading: Icon(Icons.message_outlined, color: Colors.grey),
                    title: Text('Messages',
                        style: Theme.of(context).textTheme.bodyText1),
                    onTap: () => {}),
                Divider(),
                ListTile(
                    leading: Icon(Icons.settings, color: Colors.grey),
                    title: Text('Mon compte',
                        style: Theme.of(context).textTheme.bodyText1),
                    onTap: () => {
                          setState(() => page = Account())
                          /*Navigator.pushNamed(context, '/myAccount')*/
                        }),
                ListTile(
                    leading: Icon(Icons.info_outline, color: Colors.grey),
                    title: Text('A propos',
                        style: Theme.of(context).textTheme.bodyText1),
                    onTap: () => {Navigator.pushNamed(context, '/aboutApp')}),
                ListTile(
                    leading: Icon(Icons.star_rate, color: Colors.yellow[600]),
                    title: Text("Noter l'application",
                        style: Theme.of(context).textTheme.bodyText1),
                    onTap: () => {}),
                ListTile(
                    leading: Icon(Icons.share_outlined, color: Colors.grey),
                    title: Text("Partager l'application",
                        style: Theme.of(context).textTheme.bodyText1),
                    onTap: () => {}),
                ListTile(
                    leading:
                        Icon(Icons.exit_to_app_rounded, color: Colors.grey),
                    title: Text('Déconnexion',
                        style: Theme.of(context).textTheme.bodyText1),
                    onTap: firebaseUser == null
                        ? null
                        : () async {
                            await context.read<AuthService>().signOut();
                          }),
              ]))))
        ]));
  }
}
