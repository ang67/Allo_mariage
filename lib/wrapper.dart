import 'package:allo_mariage/views/base.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:allo_mariage/views/authHub/authHub.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();
    print('********wrapper******');
    print(firebaseUser);
    if (firebaseUser != null) {
      print('AAAAAAAAAAAAAAAAAAAAAAAA');
      return new BaseScreen();
    } else {
      print('BBBBBBBBBBBBBBBBBBBBBBB');
      return AuthHub();
    }
  }
}
