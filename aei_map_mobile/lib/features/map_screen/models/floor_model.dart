import 'room_model.dart';

class Floor{
  int id;
  int number;
  List<RoomModel> rooms;

  Floor(this.id, this.number, this.rooms, this.path);

  String path;

  Floor.fromJson(Map<String, dynamic> json) {
    Floor(
      id = json['id'] as int,
      number = json['number'] as int,
      rooms = (json['rooms'] as List<dynamic>)
          .map((e) => RoomModel.fromJson(e as Map<String, dynamic>))
          .toList(),
      path = json['path'] as String ?? '',
    );
  }

  Map<String, dynamic> floorToJson(Floor instance) => <String, dynamic>{
    'id': instance.id,
    'number': instance.number,
    'rooms': instance.rooms,
    'path': instance.path,
  };


}