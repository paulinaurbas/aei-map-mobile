import 'package:aei_map_mobile/routes.dart';
import 'package:aei_map_mobile/styles/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'features/main_screen/screens/main_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Flutter Demo',
      initialRoute: '/',
      routes: customRoutes,
      theme: CustomTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: MainScreen(),
    );
  }
}
