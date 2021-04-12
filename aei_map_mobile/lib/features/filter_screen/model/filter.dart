import 'package:aei_map_mobile/features/filter_screen/model/string_id.dart';

class Filter {
  // TODO: Change the level of name and ID. Do not
  //       store it as StringId but just String
  //       and int. Align it with the backend and OpenAPI.
  StringId name;
  List<StringId> possibleValues;

  Filter(this.name, this.possibleValues);

  Filter.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        possibleValues = json["possibleValues"];
}
