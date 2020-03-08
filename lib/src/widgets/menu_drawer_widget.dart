import 'package:flutter/material.dart';

import 'package:bogo_ambiental_app_movil/src/shared_preferences/user_preferences.dart';

class MenuDrawerWidget extends StatelessWidget {
  final _prefs = new UserPreferences();
  
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: Text(
              '${_prefs.name} ${_prefs.lastName}',
              style: TextStyle(color: Colors.white)
            ),
            accountEmail: Text(
              _prefs.uid,
              style: TextStyle(color: Colors.white)
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text("NV"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.settings),
            title: Text('Ajustes'),
            onTap: () {},
          )
        ],
      ),

    );
  }
}