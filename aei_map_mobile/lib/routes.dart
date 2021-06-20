import 'package:aei_map_mobile/features/path_screen/screens/map_screen_with_path.dart';
import 'package:aei_map_mobile/features/filter_screen/screens/map_screen_with_filtered_rooms.dart';
import 'package:flutter/material.dart';

var customRoutes = <String, WidgetBuilder>{
  '/MapScreenWithPath': (context) => MapScreenWithPath(),
  '/MapScreenWithFilteredRooms': (context) => MapScreenWithFilteredRooms(),
};
