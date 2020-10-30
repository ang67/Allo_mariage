import 'package:allo_mariage/utils/ui_constantes.dart';
import 'package:allo_mariage/views/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
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
        navigateAfterSeconds: new TansitionScreen(),
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

class TansitionScreen extends StatelessWidget {
  bool skip = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              //logo
              FlutterLogo(
                size: 150,
              ),
              Text(APP_NAME),
              Text(APP_SLOGAN),
              //Facebook signIn button
              SignInButton(
                Buttons.Facebook,
                text: 'Continuer avec Facebook',
                onPressed: () {
                  print('Continuer avec Facebook');
                },
              ),

              //google signIn button
              SignInButton(
                Buttons.Google,
                text: 'Continuer avec Google',
                onPressed: () {
                  print('Continuer avec Google');
                },
              ),
              //default connection button
              SignInButtonBuilder(
                text: "S'inscrire avec un email",
                icon: Icons.email,
                iconColor: Colors.grey,
                onPressed: () {},
                backgroundColor: Colors.white,
                textColor: Colors.black54,
              ),
              //register  button
              FlatButton(
                onPressed: () {},
                child: Text(
                  'Se connecter',
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
              ),
              //skip button
              FlatButton(
                child: Text(
                  'Me connecter plus tard',
                  style: TextStyle(fontSize: 15, color: Colors.black54),
                ),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
