import 'package:aei_map_mobile/features/map_screen/models/node_model.dart';

class RoomModel {
  String room;
  String type;
  int id;
  int floorId;
  List <Node> listOfNodes;

  RoomModel.fromJson(Map<dynamic, dynamic> json)
      :  room = json["room"],
        floorId = json["floor_id"],
        listOfNodes= (json['nodes'] as List).map((i)=>Node.fromJson(i)).toList(),
        // List<Node>.from(json['nodes']),
        type = json["type"],
        id = json["id"];

}