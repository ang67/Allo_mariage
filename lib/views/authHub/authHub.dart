import 'package:allo_mariage/services/authService.dart';
import 'package:allo_mariage/utils/ui_constantes.dart';
import 'package:allo_mariage/views/auth/register.dart';
import 'package:allo_mariage/views/auth/signIn.dart';
import 'package:allo_mariage/views/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

class AuthHub extends StatefulWidget {
  @override
  _AuthHubState createState() => _AuthHubState();
}

class _AuthHubState extends State<AuthHub> {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    if (firebaseUser != null) {
      return BaseScreen();
    } else {
      return Scaffold(
        body: Center(
          child: Stack(
            children: <Widget>[
              Opacity(
                opacity: 1,
                child: Image.network(
                  'https://i.la-croix.com/729x486/smart/2018/03/01/1200917464/233-725-mariages-heterosexuels-homosexuels-celebres-2016_0.jpg',
                  fit: BoxFit.cover,
                  width: double.maxFinite,
                  height: double.maxFinite,
                ),
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10),
                alignment: Alignment.center,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    //logo
                    FlutterLogo(
                      size: 150,
                    ),
                    Text(
                      APP_NAME,
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(color: Colors.white),
                    ),
                    Text(APP_SLOGAN,
                        style: TextStyle(
                          color: Colors.white,
                        )),
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
                        context.read<AuthService>().googleSignIn();
                      },
                    ),
                    //default connection button
                    SignInButtonBuilder(
                      text: "S'inscrire avec un email",
                      icon: Icons.email,
                      iconColor: Colors.grey,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return Register();
                            },
                          ),
                        );
                      },
                      backgroundColor: Colors.white,
                      textColor: Colors.black54,
                    ),
                    //register  button
                    FlatButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return SignIn();
                            },
                          ),
                        );
                      },
                      child: Text(
                        'Se connecter',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.pink,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    //skip button
                    FlatButton(
                      child: Text(
                        'Me connecter plus tard',
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.pink,
                            fontWeight: FontWeight.bold),
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
