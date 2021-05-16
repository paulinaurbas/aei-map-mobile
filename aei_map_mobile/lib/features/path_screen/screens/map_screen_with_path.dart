import 'package:aei_map_mobile/features/map_screen/screens/map_screen.dart';
import 'package:flutter/material.dart';

class MapScreenWithPath extends StatelessWidget {

  const MapScreenWithPath({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar( backgroundColor: Colors.transparent,
        leading: BackButton(
            color: Colors.white
        ),
        elevation: 0.0,),
      body: MapScreen(isScreenWithPath: true),
    );
  }
}