import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

class BottomNavBarWidget extends StatefulWidget {
  @override
  _BottomNavBarWidgetState createState() => _BottomNavBarWidgetState();
}

class _BottomNavBarWidgetState extends State<BottomNavBarWidget> {

  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
  return BottomNavyBar(
    selectedIndex: _selectedIndex,
    showElevation: true, // use this to remove appBar's elevation
    onItemSelected: (index) => setState(() {
    _selectedIndex = index;
    _selectTab(context);
    }),
    items: [
      BottomNavyBarItem(
        icon: Icon(Icons.home),
        title: Text('Home'),
        activeColor: Colors.red,
      ),
      BottomNavyBarItem(
        icon: Icon(Icons.people),
        title: Text('Users'),
        activeColor: Colors.purpleAccent
      ),
      BottomNavyBarItem(
        icon: Icon(Icons.message),
        title: Text('Messages'),
        activeColor: Colors.pink
      ),
      BottomNavyBarItem(
        icon: Icon(Icons.settings),
        title: Text('Settings'),
        activeColor: Colors.blue
      ),
    ],
  );
  }

  void _selectTab(BuildContext context) {
    switch (_selectedIndex) {
    case 0:
      Navigator.pushNamed(context, 'home');
      break;
      case 1:
       debugPrint (" my index 1 ");
      break;
      case 2:
       debugPrint (" my index 2 ");
      break;
    }
  }
}