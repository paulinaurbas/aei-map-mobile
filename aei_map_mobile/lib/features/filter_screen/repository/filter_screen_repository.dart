import 'package:aei_map_mobile/features/filter_screen/data_sources/filter_screen_api_provider.dart';
import 'package:aei_map_mobile/features/filter_screen/model/model.dart';

class FilterScreenRepository {
  FilterScreenApiProvider _filterScreenApiProvider = FilterScreenApiProvider();

  Future<List<int>> getFilteredRooms(List<Filter> checkedFilters) =>
      _filterScreenApiProvider.getFilteredRooms(checkedFilters);

  Future<List<Filter>> getFilters() => _filterScreenApiProvider.getFilters();
}
