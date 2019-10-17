import 'package:bogo_ambiental_app_movil/src/services/user_service.dart';
import 'package:bogo_ambiental_app_movil/src/utils/dialogs.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;

class MenuDrawerWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Container(),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/menu-img.jpg'),
                fit: BoxFit.cover 
              )
            ),
          ),
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
    }else{
      showAlertExample(context, response['error']);
    }
  }
}