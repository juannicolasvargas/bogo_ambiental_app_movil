import 'package:bogo_ambiental_app_movil/src/utils/sessions.dart';
import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/routes/routes.dart';
import 'package:bogo_ambiental_app_movil/src/blocs/provider.dart';
import 'package:bogo_ambiental_app_movil/src/shared_preferences/user_preferences.dart';
import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = new UserPreferences();
  await prefs.initPrefs();
 runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final prefs = new UserPreferences();
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
        DeviceOrientation.portraitDown,
      ]);
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bogotá Ambiental',
        theme: ThemeData(
          primaryColor: Color.fromRGBO(90, 180, 178, 1.0)
        ),
        routes: getRoutes(),
        initialRoute: _initialRoute()
      )
    );
  }

  String _initialRoute() {
    return Sessions().isUserExists() ? 'home' : 'login';
  }
}
