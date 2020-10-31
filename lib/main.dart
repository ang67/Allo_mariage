import 'package:allo_mariage/services/authService.dart';
import 'package:allo_mariage/utils/ui_constantes.dart';
import 'package:allo_mariage/views/authHub/authHub.dart';
import 'package:allo_mariage/views/theme.dart';
import 'package:allo_mariage/wrapper.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

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
          //'/help': (context) => HelpScreen(),
          //'/about': (context) => AboutAppPage(),
          '/Wrapper': (context) => Wrapper(),

          //
        },
      ),
    );
  }
}
