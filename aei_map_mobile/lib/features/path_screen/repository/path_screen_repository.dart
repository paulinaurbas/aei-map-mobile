import 'package:aei_map_mobile/features/map_screen/models/all_paths.dart';
import 'package:aei_map_mobile/features/map_screen/models/floor_model.dart';
import 'package:aei_map_mobile/features/path_screen/data_sources/path_screen_api_provider.dart';

class PathScreenRepository {
  PathScreenApiProvider _pathScreenApiProvider = PathScreenApiProvider();

  Future<AllPaths> findPathBetweenPoints(int roomNumberStart, int roomNumberEnd) =>
      _pathScreenApiProvider.findPathBetweenPoints(roomNumberStart, roomNumberEnd);
}
