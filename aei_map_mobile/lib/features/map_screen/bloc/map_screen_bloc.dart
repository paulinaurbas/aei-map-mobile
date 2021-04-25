import 'package:aei_map_mobile/features/map_screen/models/room_model.dart';
import 'package:aei_map_mobile/features/map_screen/repository/map_screen_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class MapBloc extends BlocProvider {
  final MapScreenRepository _mapScreenRepository = MapScreenRepository();
  BehaviorSubject <List<RoomModel>> roomList = BehaviorSubject();
  BehaviorSubject <List<int>> floorList = BehaviorSubject();

  getFloorsId(BuildContext context) async => await _mapScreenRepository.getFloorsId(context).then((value) => floorList.sink.add(value));

  getRoomList(BuildContext context, int floorNumber) => _mapScreenRepository.listWithRooms(context, floorNumber).then((value) => roomList.sink.add(value));


  @override
  void dispose() {
    roomList.close();
    floorList.close();
  }
}