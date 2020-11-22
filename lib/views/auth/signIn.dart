import 'package:allo_mariage/services/authService.dart';
import 'package:allo_mariage/utils/ui_constantes.dart';
import 'package:allo_mariage/views/auth/passewordReset.dart';
import 'package:allo_mariage/views/auth/register.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  //final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String email = '';
  String password = '';
  String error = '';

  bool isObscure = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: ListView(
        primary: true,
        children: <Widget>[
          FlutterLogo(size: 80.0),
          Center(
              child: Text('$APP_NAME',
                  style: Theme.of(context).textTheme.headline1)),

          //Facebook signIn button
          SignInButton(
            Buttons.Facebook,
            text: 'Continuer avec Facebook',
            onPressed: () {
              print('Continuer avec Facebook');
              context.read<AuthService>().facebookLogIn();
            },
          ),
          SizedBox(height: 10.0),
          //google signIn button
          SignInButton(
            Buttons.Google,
            text: 'Continuer avec Google',
            onPressed: () {
              context.read<AuthService>().googleSignIn();
            },
          ),
          SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              FlatButton(
                onPressed: null,
                child: Text('Connection',
                    style: Theme.of(context)
                        .textTheme
                        .headline2
                        .copyWith(color: Theme.of(context).primaryColor)),
              ),
              Flexible(
                child: FlatButton(
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
                  child: Text('Nouveau compte',
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: Colors.grey)),
                ),
              ),
            ],
          ),
          Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  TextFormField(
                      cursorColor: Theme.of(context).accentColor,
                      keyboardType: TextInputType.emailAddress,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(),
                      decoration: InputDecoration(
                        hintText: ' Saisir email...',
                        hintStyle: TextStyle(
                            color: Colors.black38,
                            fontStyle: FontStyle.italic,
                            fontSize: 14),
                        enabledBorder: UnderlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.black38, width: 0.5)),
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                                color: Theme.of(context).accentColor,
                                width: 1.0)),
                        prefixIcon: const Icon(
                          Icons.email,
                          color: Colors.grey,
                        ),
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Saisir un email' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      }),
                  SizedBox(height: 10.0),
                  TextFormField(
                      cursorColor: Theme.of(context).accentColor,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(),
                      decoration: InputDecoration(
                          hintText: ' Saisir mot de passe...',
                          hintStyle: TextStyle(
                              color: Colors.black38,
                              fontStyle: FontStyle.italic,
                              fontSize: 14),
                          enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Colors.black38, width: 0.5)),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color: Theme.of(context).accentColor,
                                  width: 1.0)),
                          prefixIcon: const Icon(
                            Icons.lock,
                            color: Colors.grey,
                          ),
                          suffixIcon: isObscure
                              ? IconButton(
                                  icon: Icon(Icons.visibility_off,
                                      color: Colors.grey),
                                  onPressed: () {
                                    setState(() => isObscure = false);
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.visibility,
                                      color: Colors.grey),
                                  onPressed: () {
                                    setState(() => isObscure = true);
                                  },
                                )),
                      validator: (val) => val.length < 6
                          ? 'Entrez au moins 6 caractères !'
                          : null,
                      obscureText: isObscure,
                      onChanged: (val) {
                        setState(() => password = val);
                      }),
                  SizedBox(height: 20.0),
                  FlatButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => PasswordReset()),
                      );
                    },
                    child: RichText(
                        text: TextSpan(
                            text: 'Mot de passe oublié ?',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    decoration: TextDecoration.underline))),
                  ),
                  RaisedButton(
                      onPressed: () async {
                        if (_formKey.currentState.validate()) {
                          setState(() => loading = true);

                          var result = context.read<AuthService>().signIn(
                                email: email,
                                password: password,
                              );
                          if (result == null) {
                            setState(() => error =
                                'Entrez un email ou numéro de téléphone valide !');
                            loading = false;
                            print(error);
                          } else {
                            //Navigator.pop(context, null);

                          }
                        }
                      },
                      color: Theme.of(context).accentColor,
                      child: Text('Se connecter')),
                  SizedBox(height: 15.0),
                  Text('$error',
                      style: TextStyle(color: Theme.of(context).errorColor)),
                ],
              ))
        ],
      ),
    ));
  }
}
