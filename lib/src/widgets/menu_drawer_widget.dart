import 'package:flutter/material.dart';

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
            onTap: () {},
          )
        ],
      ),

    );
  }
}