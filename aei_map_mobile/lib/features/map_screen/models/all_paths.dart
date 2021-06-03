import 'package:aei_map_mobile/features/map_screen/models/path_model.dart';

class AllPaths {
  List<PathModel> path;

  AllPaths(this.path);

  AllPaths.fromJson(Map<String, dynamic> json) {
    AllPaths(
      path = (json['floorPaths'] as List<dynamic>)
          .map((e) => PathModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}
