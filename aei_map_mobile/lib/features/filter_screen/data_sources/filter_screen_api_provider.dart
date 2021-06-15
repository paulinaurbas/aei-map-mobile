import 'dart:io';
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

  Future<Map<int, List<int>>> getFilteredRooms(
      BuildContext context, Map<int, List<int>> checkedFilters) async {
    // TODO: Get the real data. It's just a mock one
    print(checkedFilters.toString());
    // await Future.delayed(const Duration(seconds: 1));
    // String data = await DefaultAssetBundle.of(context)
    //     .loadString("assets/json/filtered_rooms.json");
    // Map<String, dynamic> jsonMap = jsonDecode(data);
    // var filteredRoomsFromJson = jsonMap['roomIds'];
    // List<int> filteredRoomsList = List<int>.from(filteredRoomsFromJson);
    // return filteredRoomsList;
    return {
      0: [1, 2, 3],
      1: [1, 2, 3],
      2: [1, 3, 5]
    };
    //   var flattenedFilterValueIds = [];
    //   checkedFilters.values.forEach((element) =>
    //       element.forEach((element) => flattenedFilterValueIds.add(element)));

    //   client.options.headers['Content-Type'] = 'application/json';
    //   final response = await client.post(
    //       'https://aeimap.azurewebsites.net/api/FilteredRoom',
    //       data: {'filterIds': flattenedFilterValueIds, 'floorId': 1});
    //   if (response.statusCode == 200) {
    //     print(response.data.toString());
    //     return (response.data as List).map((v) => v as int).toList();
    //   } else {
    //     print('${response.statusCode} : ${response.data.toString()}');
    //     throw response.statusCode;
    //   }
    // }
  }
}
