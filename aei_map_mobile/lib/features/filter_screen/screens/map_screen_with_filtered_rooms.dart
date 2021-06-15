import 'package:aei_map_mobile/features/map_screen/screens/map_screen.dart';
import 'package:flutter/material.dart';

class MapScreenWithFilteredRooms extends StatelessWidget {
  Map<int, List<int>> filteredRooms;

  MapScreenWithFilteredRooms({Key key, this.filteredRooms}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    filteredRooms = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: BackButton(color: Colors.white),
        elevation: 0.0,
      ),
      body: MapScreen(
        isScreenWithFilteredRooms: true,
        filteredRooms: filteredRooms,
      ),
    );
  }
}
