import 'package:aei_map_mobile/features/filter_screen/model/string_id.dart';

class Filter {
  String name;
  int id;
  List<StringId> possibleValues;

  Filter(this.name, this.possibleValues);

  Filter.fromJson(Map<String, dynamic> json)
      : name = json["name"] as String,
        id = json["id"] as int,
        possibleValues = (json["possibleValues"] as List<dynamic>)
            .map((e) => StringId.fromJson(e as Map<String, dynamic>))
            .toList();
}
