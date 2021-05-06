import 'package:aei_map_mobile/features/filter_screen/model/filter.dart';
import 'package:aei_map_mobile/features/filter_screen/model/string_id.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'dart:convert';

class FilterScreenApiProvider {
  Future<List<Filter>> getFilters(BuildContext context) async {
    // TODO: Get the real data. It's just a mock one
    await Future.delayed(const Duration(seconds: 1));
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/filters.json");
    Map<String, dynamic> jsonMap = jsonDecode(data);
    var filtersList =
        (jsonMap['filters'] as List).map((f) => Filter.fromJson(f)).toList();
    return filtersList;
  }

  Future<List<int>> getFilteredRooms(
      BuildContext context, List<Filter> checkedFilters) async {
    // TODO: Get the real data. It's just a mock one
    await Future.delayed(const Duration(seconds: 1));
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/filtered_rooms.json");
    Map<String, dynamic> jsonMap = jsonDecode(data);
    var filteredRoomsFromJson = jsonMap['roomIds'];
    List<int> filteredRoomsList = List<int>.from(filteredRoomsFromJson);
    return filteredRoomsList;
  }
}
