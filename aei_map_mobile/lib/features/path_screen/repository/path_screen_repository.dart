import 'package:aei_map_mobile/features/path_screen/data_sources/path_screen_api_provider.dart';

class PathScreenRepository {
  PathScreenApiProvider _pathScreenApiProvider = PathScreenApiProvider();

  Future findPathBetweenPoints() =>
      _pathScreenApiProvider.findPathBetweenPoints();
}
