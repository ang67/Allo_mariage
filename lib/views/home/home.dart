import 'package:allo_mariage/views/widgets/search/search_field.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:provider/provider.dart';
import 'package:allo_mariage/models/user.dart' as models;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    var userData = (context.watch<models.User>());
    // print(userData);
    // print(userData);
    // print(userData);
    // print(userData);
    // print(userData);
    // print(userData);
    // print(userData);
    // print(userData);
    // print(userData);
    // print(userData);
    // print('///');
    // print(userData);

    int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 60 * 60;
    return Scaffold(
      body: ListView(children: <Widget>[
        Container(
          decoration: BoxDecoration(
            color: Colors.black,
          ),
          height: 250,
          child: Stack(
            children: [
              Opacity(
                opacity: 0.7,
                child: Container(
                  child: Image.network(
                    'https://i.la-croix.com/729x486/smart/2018/03/01/1200917464/233-725-mariages-heterosexuels-homosexuels-celebres-2016_0.jpg',
                    fit: BoxFit.cover,
                    width: double.maxFinite,
                    height: double.maxFinite,
                  ),
                ),
              ),
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    FlutterLogo(
                      size: 64,
                    ),
                    Text(
                      firebaseUser == null
                          ? 'Vive le Mariage !'
                          : '${userData} & Marry',
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    OutlineButton(
                        highlightedBorderColor: Colors.white54,
                        borderSide: BorderSide(width: 1.0, color: Colors.white),
                        onPressed: () {},
                        child: Text(
                            firebaseUser == null
                                ? 'Accedez ou Enregistrer-vous'
                                : 'Ajouter photo',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.white))),
                  ],
                ),
              ),
              Positioned(
                  height: 50,
                  width: MediaQuery.of(context).size.width,
                  bottom: 0,
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      Colors.pink[500],
                      Colors.pink[200],
                      Colors.pink[500],
                      Colors.pink[200]
                    ])),
                    child: CountdownTimer(
                      endTime: endTime,
                      widgetBuilder: (_, CurrentRemainingTime time) {
                        return Center(
                          child: Text(
                            '${time.days ?? 0} jours : ${time.hours ?? 00} heures : ${time.min ?? 00} min : ${time.sec ?? 00} s',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .copyWith(color: Colors.white),
                          ),
                        );
                      },
                    ),
                  ))
            ],
          ),
        ),
        SizedBox(height: 10),
        SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(
                  onTap: () {},
                  child: Card(
                      elevation: 2.0,
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.fact_check_outlined),
                            Text(
                              'Tâches',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Text('0 sur 180')
                          ],
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                      elevation: 2.0,
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.home_repair_service_outlined),
                            Text(
                              'Prestataires',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Text('0 sur 20')
                          ],
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                      elevation: 2.0,
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.people_outlined),
                            Text(
                              'Invités',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Text('2 sur 110')
                          ],
                        ),
                      )),
                ),
                InkWell(
                  onTap: () {},
                  child: Card(
                      elevation: 2.0,
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: EdgeInsets.all(10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Icon(Icons.money),
                            Text(
                              'Budget',
                              style: Theme.of(context).textTheme.headline2,
                            ),
                            Text('- € / - €')
                          ],
                        ),
                      )),
                ),
              ],
            )),
        SizedBox(height: 15),
        SearchField(),
      ]),
    );
  }
}
