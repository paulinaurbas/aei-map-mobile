import 'package:aei_map_mobile/features/filter_screen/model/model.dart';
import 'dart:async';

class FilterScreenApiProvider {
  Future<FiltersGetResponse> getFilters() async {
    // TODO: Get the real data. It's just a mock one
    await new Future.delayed(const Duration(seconds: 3));
    return FiltersGetResponse([
      Filter(StringDataType("does it have computers", 0), [
        StringDataType("no", 0),
        StringDataType("a bunch", 1),
        StringDataType("a lot", 2)
      ]),
      Filter(StringDataType("does it have windows", 1), [
        StringDataType("no", 0),
        StringDataType("yes", 1),
      ]),
      Filter(StringDataType("how big it is", 2), [
        StringDataType("super small", 0),
        StringDataType("decent", 1),
        StringDataType("huge", 2),
        StringDataType("it's like football field", 3),
      ]),
      Filter(StringDataType("is it comfortable", 3), [
        StringDataType("as hell", 0),
        StringDataType("pretty much yeah", 1),
        StringDataType("it's dope", 2),
      ]),
    ], "");
  }

  Future<FilteredRoomsGetResponse> getFilteredRooms(
      List<Filter> checkedFilters) async {
    // TODO: Get the real data. It's just a mock one
    await new Future.delayed(const Duration(seconds: 3));
    return FilteredRoomsGetResponse([3, 14, 15, 92], "");
  }
}
