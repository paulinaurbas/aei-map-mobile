import 'package:aei_map_mobile/features/map_screen/models/node_model.dart';

class PathModel{
  String floorId;
  List<Node> path;

  PathModel(this.floorId, this.path);

  PathModel.fromJson(Map<String, dynamic> json) {
    PathModel(
      floorId = json['floor_id'] as String,
      path = (json['path'] as List<dynamic>)
          .map((e) => Node.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

}