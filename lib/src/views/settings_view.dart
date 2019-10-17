import 'package:bogo_ambiental_app_movil/src/services/user_service.dart';
import 'package:bogo_ambiental_app_movil/src/utils/dialogs.dart';
import 'package:flutter/material.dart';

class SettingsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajustes'),
        backgroundColor: Color.fromRGBO(63, 200, 156, 1.0)
        ),
      body: ListView(
        children: <Widget>[
          ListTile(
            leading: Icon(Icons.highlight_off, color: Colors.blue,),
            title: Text('Cerrar sesión'),
            onTap: () => _signOutUser(context),
          )
        ],
      ),
    );
  }

  void _signOutUser(BuildContext context) async {
    var response = await UserService().signOut();
    if (response['status']) {
      Navigator.pop(context);
      Navigator.pushReplacementNamed(context, 'login');
    }else {
      showAlertExample(context, response['error']);
    }
  }
}