class StringId {
  String name;
  int id;

  StringId(this.name, this.id);

  StringId.fromJson(Map<String, dynamic> json)
      : name = json["name"] as String,
        id = json["id"] as int;
}
