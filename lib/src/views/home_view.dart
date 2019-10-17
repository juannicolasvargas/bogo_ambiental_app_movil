import 'package:bogo_ambiental_app_movil/src/widgets/menu_drawer_widget.dart';
import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/shared_preferences/user_preferences.dart';

class HomeView extends StatefulWidget {
  HomeView({Key key}) : super(key: key);

  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final _prefs = new UserPreferences();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        backgroundColor: Color.fromRGBO(63, 200, 156, 1.0)),
      drawer: MenuDrawerWidget(),
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