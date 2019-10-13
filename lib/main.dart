import 'package:bogo_ambiental_app_movil/src/blocs/provider.dart';
import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/routes/routes.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Bogota ambiental',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        routes: getRoutes(),
        initialRoute: 'login'
        // home: MyHomePage(title: 'Flutter Demo Home Page'),
      )
    );
  }
}
