import 'package:aei_map_mobile/features/filter_screen/model/filter.dart';
import 'package:aei_map_mobile/features/filter_screen/model/string_id.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class FilterScreenApiProvider {
  final client = Dio();

  Future<List<Filter>> getFilters(BuildContext context) async {
    // TODO: Get the real data. It's just a mock one
    // await Future.delayed(const Duration(seconds: 1));
    // String data = await DefaultAssetBundle.of(context)
    //     .loadString("assets/json/filters.json");
    // Map<String, dynamic> jsonMap = jsonDecode(data);
    // var filtersList =
    //     (jsonMap['filters'] as List).map((f) => Filter.fromJson(f)).toList();
    // return filtersList;

    var response =
        await client.get('https://aeimap.azurewebsites.net/api/Filter');
    return (response.data as List).map((f) => Filter.fromJson(f)).toList();
  }

  Future<List<int>> getFilteredRooms(
      BuildContext context, Map<int, List<int>> checkedFilters) async {
    // TODO: Get the real data. It's just a mock one
    print(checkedFilters.toString());
    await Future.delayed(const Duration(seconds: 1));
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/json/filtered_rooms.json");
    Map<String, dynamic> jsonMap = jsonDecode(data);
    var filteredRoomsFromJson = jsonMap['roomIds'];
    List<int> filteredRoomsList = List<int>.from(filteredRoomsFromJson);
    return filteredRoomsList;
  }
}
