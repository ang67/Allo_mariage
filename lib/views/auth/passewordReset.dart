import 'package:flutter/material.dart';

class PasswordReset extends StatefulWidget {
  @override
  _PasswordResetState createState() => _PasswordResetState();
}

class _PasswordResetState extends State<PasswordReset> {
  final myController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String email = '';

  String error = '';
  bool valide = false;

  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    myController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var regExp = new RegExp(
        r"^[a-z][a-z0-9.a-z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
    return Scaffold(
        body: Container(
      padding: EdgeInsets.symmetric(vertical: 20, horizontal: 30),
      child: ListView(
        primary: true,
        children: <Widget>[
          SizedBox(height: 50.0),
          Center(
              child: Text(' Réinitialisation  de mot de passe',
                  style: Theme.of(context)
                      .textTheme
                      .headline1
                      .copyWith(color: Colors.black54))),
          SizedBox(height: 60.0),
          Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  SizedBox(height: 10.0),
                  TextFormField(
                      controller: myController,
                      cursorColor: Colors.white,
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
                          color: Colors.white,
                        ),
                      ),
                      validator: (val) =>
                          (val.isEmpty) ? 'Saisir un email' : null,
                      onChanged: (val) {
                        setState(() => email = val);

                        regExp.hasMatch(val) ? valide = true : valide = false;
                      }),
                  SizedBox(height: 10.0),
                  FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: RichText(
                        text: TextSpan(text: 'Retour à la page de connexion')),
                  ),
                  RaisedButton(
                      onPressed: valide
                          ? () async {
                              if (_formKey.currentState.validate()) {}
                            }
                          : null,
                      color: Theme.of(context).accentColor,
                      child: Text('Soumettre')),
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
