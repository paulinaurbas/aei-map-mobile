class StringId {
  String name;
  int id;

  StringId(this.name, this.id);

  StringId.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        id = json["id"];
}
