class StringDataType {
  String name;
  int id;

  StringDataType(this.name, this.id);
}

class Filter {
  StringDataType name;
  List<StringDataType> possibleValues;

  Filter(this.name, this.possibleValues);
}
