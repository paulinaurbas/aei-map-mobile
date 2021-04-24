import 'package:aei_map_mobile/features/map_screen/models/room_model.dart';

class RoomsMap {
  List <RoomModel> rooms;

  RoomsMap.fromJson(Map<dynamic, dynamic> json)
      : rooms = List<RoomModel>.from(json['rooms']);

}