class StringDataType {
  String name;
  int id;

  StringDataType(this.name, this.id);

  StringDataType.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        id = json["id"];
}

class Filter {
  // TODO: Change the level of name and ID. Do not
  //       store it as StringDataType but just String
  //       and int. Align it with the backend and OpenAPI.
  StringDataType name;
  List<StringDataType> possibleValues;

  Filter(this.name, this.possibleValues);

  Filter.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        possibleValues = json["possibleValues"];
}

class FiltersGetResponse {
  List<Filter> results;
  String error;

  FiltersGetResponse(this.results, this.error);

  FiltersGetResponse.fromJson(Map<String, dynamic> json)
      : results = (json["filters"] as List)
            .map((f) => new Filter.fromJson(f))
            .toList(),
        error = "";

  FiltersGetResponse.withError(String errorValue)
      : results = List.empty(),
        error = errorValue;
}

class FilteredRoomsGetResponse {
  // Keep in mind that currenly it's defined
  // as List<String> in the OpenAPI document.
  List<int> results;
  String error;

  FilteredRoomsGetResponse(this.results, this.error);

  FilteredRoomsGetResponse.fromJson(Map<String, dynamic> json)
      : results = (json["roomIds"] as List).toList(),
        error = "";

  FilteredRoomsGetResponse.withError(String errorValue)
      : results = List.empty(),
        error = errorValue;
}
