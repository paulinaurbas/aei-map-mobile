import 'package:aei_map_mobile/styles/app_strings.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  MainScreen({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    // TODO: Change it to real screens
    Center(
      child: Text('map',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    ),
    Center(
      child: Text('filter',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    ),
    Center(
      child: Text('path',
          style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold)),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(appStrings["aeiMap"]),
      ),
      body: _children.elementAt(_currentIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped, // new
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: appStrings['mapBarIcon'],
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: appStrings['filterBarIcon'],
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.directions_walk),
            label: appStrings['pathBarIcon'],
          ),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
