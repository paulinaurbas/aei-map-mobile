import 'package:aei_map_mobile/features/map_screen/models/all_paths.dart';
import 'package:dio/dio.dart';

class PathScreenApiProvider {
 final client = Dio();

 Future<AllPaths> findPathBetweenPoints(int roomNumberStart, int roomNumberEnd) {
    return client
        .post('https://aeimap.azurewebsites.net/api/Path', data: {'startRoomNumber': roomNumberStart, 'endRoomNumber':roomNumberEnd})
        .then((value) {
          return AllPaths.fromJson(value.data);
    });
  }
}
