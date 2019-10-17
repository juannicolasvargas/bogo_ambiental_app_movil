import 'package:bogo_ambiental_app_movil/src/views/dashboard_view.dart';
import 'package:bogo_ambiental_app_movil/src/views/settings_view.dart';
import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => new _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  int _page = 0;
  PageController _c;
  @override
  void initState(){
    _c =  new PageController(
      initialPage: _page,
    );
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      bottomNavigationBar: _createNavBar(),
      body: new PageView(
        controller: _c,
        onPageChanged: (newPage){
          setState((){
            this._page=newPage;
          });
        },
        children: <Widget>[
          DashboardView(),
          SettingsView(),
          SettingsView()
        ],
      ),
    );
  }

  Widget _createNavBar() {
    return BottomNavyBar(
    selectedIndex: _page,
    showElevation: true, // use this to remove appBar's elevation
    onItemSelected: (index) {
      this._c.animateToPage(index,duration: const Duration(milliseconds: 500),curve: Curves.easeInOut);
    },
    items: [
      BottomNavyBarItem(
        icon: Icon(Icons.home),
        title: Text('Inicio'),
        // activeColor: Colors.black,
      ),
      BottomNavyBarItem(
        icon: Icon(Icons.import_contacts),
        title: Text('Retos')
      ),
      BottomNavyBarItem(
        icon: Icon(Icons.settings),
        title: Text('Ajustes')
      ),
    ],
  );
  }
}