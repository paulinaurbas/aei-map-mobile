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

  Future<List<int>> getFilteredRooms(
      BuildContext context, Map<int, List<int>> checkedFilters) async {
    var flattenedFilterValueIds = [];
    checkedFilters.values.forEach((element) =>
        element.forEach((element) => flattenedFilterValueIds.add(element)));

    client.options.headers['Content-Type'] = 'application/json';
    final response = await client.post(
        'https://aeimap.azurewebsites.net/api/FilteredRoom',
        data: {'filterIds': flattenedFilterValueIds});

    if (response.statusCode == 200) {
      return (response.data as List).map((v) => v['id'] as int).toList();
    } else {
      print('${response.statusCode} : ${response.data.toString()}');
      throw response.statusCode;
    }
  }
}
