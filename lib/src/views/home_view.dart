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
      appBar: AppBar(title: Text('Home')),
      body: Center(
        child: Text('Bienvenido ${_prefs.name}'),
      ),
    );
  }
}