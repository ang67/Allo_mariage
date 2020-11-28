import 'package:allo_mariage/utils/ui_constantes.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart' as url_launcher;

class AboutApp extends StatelessWidget {
  const AboutApp({Key key}) : super(key: key);

  // These tiles are also used as drawer nav items in home route.
  static final List<Widget> kAboutListTiles = <Widget>[
    ListTile(
      title: Text(APP_DESCRIPTION),
    ),
    Divider(),
    ListTile(
      leading: Icon(Icons.shop),
      title: Text('Rate on Google Play'),
      onTap: () => url_launcher.launch(GOOGLEPLAY_URL),
    ),
    ListTile(
      leading: Icon(Icons.bug_report),
      title: Text('Report issue'),
      onTap: () => {},
    ),
    ListTile(
      leading: Icon(Icons.open_in_new),
      title: Text('Visit my website'),
      onTap: () {} /*=> url_launcher.launch(AUTHOR_SITE)*/,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final header = ListTile(
      leading: FlutterLogo(),
      title: Text(APP_NAME),
      subtitle: Text(APP_VERSION),
      trailing: IconButton(
        icon: Icon(Icons.info),
        onPressed: () {
          showAboutDialog(
              context: context,
              applicationName: APP_NAME,
              applicationVersion: APP_VERSION,
              applicationIcon: FlutterLogo(),
              children: <Widget>[Text(APP_DESCRIPTION)]);
        },
      ),
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('A propos'),
      ),
      body: ListView(
        children: <Widget>[
          header,
          ...kAboutListTiles,
        ],
      ),
    );
  }
}
