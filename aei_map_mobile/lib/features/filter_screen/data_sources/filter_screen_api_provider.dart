import 'package:aei_map_mobile/features/filter_screen/model/filter.dart';
import 'package:aei_map_mobile/features/filter_screen/model/string_id.dart';
import 'dart:async';

class FilterScreenApiProvider {
  Future<List<Filter>> getFilters() async {
    // TODO: Get the real data. It's just a mock one
    await Future.delayed(const Duration(seconds: 1));
    return [
      Filter(StringId("does it have computers", 0),
          [StringId("no", 0), StringId("a bunch", 1), StringId("a lot", 2)]),
      Filter(StringId("does it have windows", 1), [
        StringId("no", 0),
        StringId("yes", 1),
      ]),
      Filter(StringId("how big it is", 2), [
        StringId("super small", 0),
        StringId("decent", 1),
        StringId("huge", 2),
        StringId("it's like football field", 3),
      ]),
      Filter(StringId("is it comfortable", 3), [
        StringId("as hell", 0),
        StringId("pretty much yeah", 1),
        StringId("it's dope", 2),
      ]),
    ];
  }

  Future<List<int>> getFilteredRooms(List<Filter> checkedFilters) async {
    // TODO: Get the real data. It's just a mock one
    await Future.delayed(const Duration(seconds: 1));
    return [3, 14, 15, 92];
  }
}
