import 'package:allo_mariage/services/authService.dart';
import 'package:allo_mariage/utils/ui_constantes.dart';
import 'package:allo_mariage/views/auth/signIn.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:provider/provider.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});
  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  String name = '';
  String telephone = '';
  String email = '';
  String password = '';
  String role = '';

  String error = '';
  bool isObscure = true;
  bool _termsChecked = false;

  List<String> roles = ['Mariée', 'Marié', 'Famille', 'Invité', 'Prestataire'];
  @override
  void initState() {
    super.initState();
    role = roles[0];
  }

  @override
  Widget build(BuildContext context) {
    RegExp expName =
        RegExp(r"^[a-zA-Z]+([ \-']?[a-zA-Z]+[ \-']?[a-zA-Z]+[ \-']?)[a-zA-Z]+");

    return /*loading
        ? Loading()
        : */
        Scaffold(
            body: Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: ListView(
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
                onPressed: () {
                  widget.toggleView();
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) {
                  //       return SignIn();
                  //     },
                  //   ),
                  // );
                },
                child: Text('Connection',
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1
                        .copyWith(color: Colors.grey)),
              ),
              Flexible(
                child: FlatButton(
                  onPressed: null,
                  child: Text('Nouveau compte',
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: Theme.of(context).primaryColor)),
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
                      keyboardType: TextInputType.text,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(),
                      decoration: InputDecoration(
                        hintText: ' Prénom et nom...',
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
                          Icons.person,
                          color: Colors.grey,
                        ),
                      ),
                      validator: (val) =>
                          (val.isEmpty || (!expName.hasMatch(val)))
                              ? 'Saisir votre prénom et nom}'
                              : null,
                      onChanged: (val) {
                        setState(() => name = val);
                      }),
                  SizedBox(height: 10.0),
                  TextFormField(
                      cursorColor: Theme.of(context).accentColor,
                      keyboardType: TextInputType.phone,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(),
                      decoration: InputDecoration(
                        hintText: ' Numéro de telephone...',
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
                          Icons.phone,
                          color: Colors.grey,
                        ),
                      ),
                      validator: (val) =>
                          val.isEmpty ? 'Saisir un numéro de téléphone' : null,
                      onChanged: (val) {
                        setState(() => telephone = val);
                      }),
                  SizedBox(height: 10.0),
                  TextFormField(
                      cursorColor: Theme.of(context).accentColor,
                      keyboardType: TextInputType.emailAddress,
                      style: Theme.of(context).textTheme.bodyText1.copyWith(),
                      decoration: InputDecoration(
                        hintText: ' Email...',
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
                      style: Theme.of(context).textTheme.bodyText1,
                      decoration: InputDecoration(
                          hintText: 'Mot de passe...',
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
                  SizedBox(height: 5.0),
                  /******************************** */
                  // dropdown
                  DropdownButtonFormField<String>(
                    style: Theme.of(context).textTheme.bodyText1,
                    value: role,
                    items: [...roles]
                        .map((label) => DropdownMenuItem(
                              child: Text(label.toString()),
                              value: label,
                            ))
                        .toList(),
                    hint: Text('Rôle'),
                    onChanged: (value) {
                      setState(() {
                        role = value;
                      });
                    },
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.black38, width: 0.5)),
                      focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context).accentColor,
                              width: 1.0)),
                      prefixIcon: const Icon(
                        Icons.work,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                  /******************************** */
                  SizedBox(height: 10.0),
                  CheckboxListTile(
                      value: _termsChecked,
                      title: Text(
                          "Je suis d'accord avec les termes et les conditions"),
                      controlAffinity: ListTileControlAffinity.leading,
                      onChanged: (value) {
                        setState(() => _termsChecked = value);
                      }),
                  Text('$error',
                      style: TextStyle(color: Theme.of(context).errorColor)),
                  SizedBox(height: 5.0),

                  RaisedButton(
                      disabledColor: Colors.white70,
                      onPressed: !_termsChecked
                          ? null
                          : () async {
                              if (_formKey.currentState.validate()) {
                                setState(() => loading = true);
                                var result = context
                                    .read<AuthService>()
                                    .signUp(
                                        name: name,
                                        email: email,
                                        password: password,
                                        telephone: telephone,
                                        role: role)
                                    .then((value) => {
                                          if (value == null)
                                            {
                                              setState(() => error =
                                                  'Entrez un email ou numéro de téléphone valide !')
                                            }
                                          else
                                            {
                                              // Wrap Navigator with SchedulerBinding to wait for rendering state before navigating
                                              SchedulerBinding.instance
                                                  .addPostFrameCallback((_) {
                                                Navigator.pop(context, null);
                                              })
                                            }
                                        });
                              }
                            },
                      color: Theme.of(context).accentColor,
                      child: Text("S'enregistrer")),
                  SizedBox(height: 15.0),
                ],
              ))
        ],
      ),
    ));
  }
}
