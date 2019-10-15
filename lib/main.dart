import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/routes/routes.dart';
import 'package:bogo_ambiental_app_movil/src/blocs/provider.dart';
import 'package:bogo_ambiental_app_movil/src/shared_preferences/user_preferences.dart';

void main() async {
  final prefs = new UserPreferences();
  await prefs.initPrefs();
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bogota ambiental',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(63, 63, 156, 1.0)
        ),
        routes: getRoutes(),
        initialRoute: 'login'
      )
    );
  }
}
