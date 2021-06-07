import 'package:aei_map_mobile/features/map_screen/models/node_model.dart';

class PathModel {
  int floorId;
  List<Node> path;

  PathModel(this.floorId, this.path);

  PathModel.fromJson(Map<String, dynamic> json) {
    PathModel(
      floorId = json['floorId'] as int,
      path = (json['points'] as List<dynamic>)
          .map((e) => Node.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
