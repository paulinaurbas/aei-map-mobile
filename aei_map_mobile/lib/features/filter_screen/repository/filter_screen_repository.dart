import 'package:aei_map_mobile/features/filter_screen/data_sources/filter_screen_api_provider.dart';
import 'package:aei_map_mobile/features/filter_screen/model/filter.dart';
import 'package:flutter/widgets.dart';

class FilterScreenRepository {
  FilterScreenApiProvider _filterScreenApiProvider = FilterScreenApiProvider();

  Future<List<Filter>> getFilters(BuildContext context) =>
      _filterScreenApiProvider.getFilters(context);

  Future<Map<int, List<int>>> getFilteredRooms(
          BuildContext context, Map<int, List<int>> checkedFilters) =>
      _filterScreenApiProvider.getFilteredRooms(context, checkedFilters);
}
