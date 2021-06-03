import 'package:aei_map_mobile/features/map_screen/models/all_paths.dart';
import 'package:aei_map_mobile/features/map_screen/screens/map_screen.dart';
import 'package:flutter/material.dart';

class MapScreenWithPath extends StatelessWidget {
  MapScreenWithPath({Key key, this.pathForFloor}) : super(key: key);
  AllPaths pathForFloor;
  @override
  Widget build(BuildContext context) {
    pathForFloor = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Colors.white),
        elevation: 0.0,
      ),
      body: MapScreen(isScreenWithPath: true, paths: pathForFloor,),
    );
  }
}
