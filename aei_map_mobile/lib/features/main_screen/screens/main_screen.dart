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
    // TODO: Change the placeholders to the real screens
    _placeholder('map'), _placeholder('filter'), _placeholder('path'),
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
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: appStrings['mapBarIcon'],
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: appStrings['filterBarIcon'],
          ),
          BottomNavigationBarItem(
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

// TODO: Delete it after all
Widget _placeholder(String s) => Center(
      child: Text(s,
          style: TextStyle(
              fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black)),
    );
