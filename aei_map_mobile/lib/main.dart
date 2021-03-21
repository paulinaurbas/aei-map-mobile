import 'package:aei_map_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';

import 'features/main_screen/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: CustomTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
