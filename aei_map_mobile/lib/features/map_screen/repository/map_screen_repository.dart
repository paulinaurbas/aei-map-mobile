import 'package:aei_map_mobile/features/map_screen/data_sources/map_screen_api_provider.dart';
import 'package:aei_map_mobile/features/map_screen/models/floor_model.dart';
import 'package:aei_map_mobile/features/map_screen/models/room_model.dart';
import 'package:flutter/cupertino.dart';

class MapScreenRepository {
  MapApiProvider mapApiProvider = MapApiProvider();

  Future <Floor> listWithRooms(BuildContext context, int floorNumber) => mapApiProvider.drawMapFromCoordinates(context, floorNumber);

  Future<List<int>> getFloorsId(BuildContext context) =>  mapApiProvider.getFloorsId(context);
}