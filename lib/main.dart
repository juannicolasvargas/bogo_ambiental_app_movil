import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: getRoutes(),
      initialRoute: 'login'
      // home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}
