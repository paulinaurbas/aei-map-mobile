import 'package:aei_map_mobile/features/filter_screen/screens/filter_screen.dart';
import 'package:aei_map_mobile/features/map_screen/screens/map_screen.dart';
import 'package:aei_map_mobile/features/path_screen/screens/path_screen.dart';
import 'package:aei_map_mobile/styles/app_colors.dart';
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
    MapScreen(
      isScreenWithPath: false,
    ),
    FilterScreen(),
    PathScreen()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children.elementAt(_currentIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border(top: BorderSide(color: Colors.white, width: 1.0))),
        child: BottomNavigationBar(
          backgroundColor: appColors['background_color'],
          unselectedItemColor: Colors.white,
          onTap: onTabTapped,
          currentIndex: _currentIndex,
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
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }
}
