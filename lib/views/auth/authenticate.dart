import 'package:allo_mariage/views/auth/register.dart';
import 'package:allo_mariage/views/auth/signIn.dart';
import 'package:flutter/material.dart';

class Authenticate extends StatefulWidget {
  final bool signIn;

  const Authenticate({Key key, this.signIn}) : super(key: key);
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn;

  @override
  void initState() {
    super.initState();
    showSignIn = widget.signIn;
  }

  void toggleView() async {
    setState(() => showSignIn = !showSignIn);
  }

  @override
  Widget build(BuildContext context) {
    if (showSignIn) {
      return SignIn(toggleView: toggleView);
    } else {
      return Register(toggleView: toggleView);
    }
  }
}
