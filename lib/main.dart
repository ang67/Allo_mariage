import 'package:allo_mariage/services/authService.dart';
import 'package:allo_mariage/utils/ui_constantes.dart';
import 'package:allo_mariage/views/about/about.dart';
import 'package:allo_mariage/views/account/account.dart';
import 'package:allo_mariage/views/authHub/authHub.dart';
import 'package:allo_mariage/views/base.dart';
import 'package:allo_mariage/views/theme.dart';
import 'package:allo_mariage/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:allo_mariage/models/user.dart' as models;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(new MyApp());
  });
}

class MyApp extends StatelessWidget {
  final String title = APP_NAME;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(FirebaseAuth.instance),
        ),
        Provider<models.User>(
          create: (_) => AuthService(FirebaseAuth.instance).currentUser,
        ),
        StreamProvider(
          create: (context) => context.read<AuthService>().authStateChanges,
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: title,
        theme: buildBaseTheme(),
        home: AuthHub(),
        initialRoute: '/',
        routes: {
          '/myAccount': (context) => Account(),
          '/aboutApp': (context) => AboutApp(),
          '/base': (context) => BaseScreen(),
          '/authHub': (context) => AuthHub(),
          '/Wrapper': (context) => Wrapper(),

          //
        },
      ),
    );
  }
}
