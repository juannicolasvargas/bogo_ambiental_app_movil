import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/shared_preferences/user_preferences.dart';

class DashboardView extends StatefulWidget {
  DashboardView({Key key}) : super(key: key);

  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final _prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromRGBO(63, 200, 156, 1.0)),
      body: Column(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 40.0),
            child: Center(child: Text('Bienvenido ${_prefs.name}')),
          ),
          Container(
            padding: EdgeInsets.only(top: 40.0),
            child: Center(child: Text('Numero id ${_prefs.id}')),
          ),
          Container(
            padding: EdgeInsets.only(top: 40.0),
            child: Center(child: Text('Apellido ${_prefs.lastName}')),
          ),
        ],            
      ),
    );
  }
}