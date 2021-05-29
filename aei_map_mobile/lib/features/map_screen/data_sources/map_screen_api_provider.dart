import 'dart:convert';

import 'package:aei_map_mobile/features/map_screen/models/all_paths.dart';
import 'package:aei_map_mobile/features/map_screen/models/floor_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

class MapApiProvider {
  final client = Dio();

  Future<Floor> drawMapFromCoordinates(
      BuildContext context, int floorNumber) async {
    return client
        .get('https://aeimap.azurewebsites.net/api/Floor/$floorNumber')
        .then((value) {
      return Floor.fromJson(value.data);
    });
  }

  Future<AllPaths> drawPathFromCoordinates(
      BuildContext context, int floorNumber) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/path.json");

    Map<String, dynamic> jsonMap = jsonDecode(data);
    Map<String, dynamic> decodedtRooms = jsonDecode(data);
    return AllPaths.fromJson(decodedtRooms);
  }

  Future<List<int>> getFloorsId(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/floors.json");

    Map<String, dynamic> jsonMap = jsonDecode(data);
    var genreIdsFromJson = jsonMap['floors_ids'];
    List<int> genreIdsList = new List<int>.from(genreIdsFromJson);
    return genreIdsList;
  }
}
