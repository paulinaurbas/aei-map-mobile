import 'dart:convert';
import 'package:aei_map_mobile/features/map_screen/models/room_model.dart';
import 'package:flutter/cupertino.dart';

class MapApiProvider {

  Future <List<RoomModel>> drawMapFromCoordinates(BuildContext context) async {
    String data = await DefaultAssetBundle.of(context).loadString("assets/json/map.json");

    Map<String, dynamic> decodedDoughnuts = jsonDecode(data);
    List<dynamic> decodedJson =  decodedDoughnuts['rooms'];
    return decodedJson.map((elem) => RoomModel.fromJson(elem)).toList();
  }
}