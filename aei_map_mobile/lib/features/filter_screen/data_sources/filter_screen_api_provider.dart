import 'package:aei_map_mobile/features/filter_screen/model/filter.dart';
import 'package:aei_map_mobile/features/filter_screen/model/string_id.dart';
import 'dart:async';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:dio/dio.dart';

class FilterScreenApiProvider {
  final client = Dio();

  Future<List<Filter>> getFilters(BuildContext context) async {
    final response =
        await client.get('https://aeimap.azurewebsites.net/api/Filter');
    if (response.statusCode == 200)
      return (response.data as List).map((f) => Filter.fromJson(f)).toList();
    else {
      print('${response.statusCode} : ${response.data.toString()}');
      throw response.statusCode;
    }
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
    print(jsonEncode(checkedFilters.values.toList()));

    // final response = await client.post(
    //     'https://aeimap.azurewebsites.net/api/FilteredRoom',
    //     data: {'filterIds': jsonEncode(checkedFilters.values.toList())});
    // if (response.statusCode == 200)
    //   return response.data as List;
    // else {
    //   print('${response.statusCode} : ${response.data.toString()}');
    //   throw response.statusCode;
    // }
  }
}
