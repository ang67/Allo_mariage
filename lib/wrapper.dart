import 'package:allo_mariage/views/authHub/authHub.dart';
import 'package:allo_mariage/views/base.dart';
import 'package:flutter/material.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool isAuth = true;

    if (isAuth) {
      return BaseScreen();
    } else {
      return AuthHub();
    }
  }
}
