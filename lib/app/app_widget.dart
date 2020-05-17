import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:senhordosaneis/app/modules/home/home_module.dart';
import 'package:senhordosaneis/app/modules/home/home_page.dart';
import 'package:senhordosaneis/app/modules/logon/logon_page.dart';
import 'package:senhordosaneis/app/modules/personagensRaca/personagensRaca_page.dart';
import 'modules/personagens/personagens_page.dart';
import 'utils/routes.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        Routes.home: (context) => HomePage(),
        Routes.personagensRaca: (context) => PersonagensRacaPage(),
        Routes.personagens: (context) => PersonagensPage(),
        Routes.logon: (context) => LogonPage(),
      },
      title: 'Flutter Slidy',
      theme: ThemeData(
        primaryColor: Colors.grey,
        cursorColor: Colors.grey,
        primarySwatch: Colors.orange,
        accentColor: Colors.orange,
        accentIconTheme: Theme.of(context).accentIconTheme.copyWith(
          color: Colors.white
        ),
        primaryIconTheme: Theme.of(context).primaryIconTheme.copyWith(
          color: Colors.white
        ),
        primaryTextTheme: Theme
          .of(context)
          .primaryTextTheme
          .apply(bodyColor: Colors.white)),
      home: StreamBuilder<Object>(
          stream: FirebaseAuth.instance.onAuthStateChanged,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              FirebaseUser user = snapshot.data;

              if (user == null) {
                return LogonPage();
              }

              return HomeModule();
            } else {
              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
    );
  }
}
