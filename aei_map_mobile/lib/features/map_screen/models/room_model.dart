import 'package:aei_map_mobile/features/map_screen/models/node_model.dart';

class RoomModel {
  String room;
  String type;
  int id;
  int floorId;
  List<Node> listOfNodes;

  RoomModel.fromJson(Map<dynamic, dynamic> json)
      : room = json["name"],
        floorId = json["floor_id"],
        listOfNodes = (json['points'] as List<dynamic>)
            .map((e) => Node.fromJson(e as Map<String, dynamic>))
            .toList(),
        type = json["type"],
        id = json["id"];
}
