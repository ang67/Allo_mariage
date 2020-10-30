import 'package:allo_mariage/views/authHub/authHub.dart';
import 'package:allo_mariage/views/theme.dart';
import 'package:allo_mariage/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:splashscreen/splashscreen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  final String title = "AlloEvent";
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: title,
      theme: buildBaseTheme(),
      home: new SplashScreen(
        seconds: 3,
        //navigateAfterSeconds: new BaseScreen(),
        navigateAfterSeconds: new Wrapper(),
        title: new Text(
          'AlloEvent',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 25.0),
        ),
        image: new Image.network(
            'https://flutter.io/images/catalog-widget-placeholder.png'),
        backgroundColor: Colors.white,
        styleTextUnderTheLoader: new TextStyle(),
        photoSize: 100.0,
        loaderColor: Theme.of(context).accentColor,
      ),
      initialRoute: '/',
      // routes: {
      //   '/help': (context) => HelpScreen(),
      //   '/about': (context) => AboutAppPage(),

      //   //
      // },
    );
  }
}
