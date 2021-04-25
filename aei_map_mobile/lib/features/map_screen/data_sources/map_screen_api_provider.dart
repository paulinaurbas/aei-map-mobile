import 'dart:convert';
import 'package:aei_map_mobile/features/map_screen/models/room_model.dart';
import 'package:flutter/cupertino.dart';

class MapApiProvider {

  Future <List<RoomModel>> drawMapFromCoordinates(BuildContext context, int floorNumber) async {
    String data = '';
    if(floorNumber == 2){
       data = await DefaultAssetBundle.of(context).loadString("assets/json/map_floor_zero.json");
    } else {
       data = await DefaultAssetBundle.of(context).loadString("assets/json/map.json");
    }
    Map<String, dynamic> decodedtRooms = jsonDecode(data);
    List<dynamic> decodedJson =  decodedtRooms['rooms'];
    return decodedJson.map((elem) => RoomModel.fromJson(elem)).toList();
  }

  Future<List<int>> getFloorsId(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/floors.json");


    Map<String, dynamic> jsonMap = jsonDecode(data);
    var genreIdsFromJson = jsonMap['floors_ids'];
    List<int> genreIdsList = new List<int>.from(genreIdsFromJson);
    return genreIdsList;
  }
}