import 'dart:async';

import 'package:aei_map_mobile/features/map_screen/models/all_paths.dart';
import 'package:aei_map_mobile/features/map_screen/models/floor_model.dart';
import 'package:aei_map_mobile/features/map_screen/models/path_model.dart';
import 'package:aei_map_mobile/features/map_screen/models/room_model.dart';
import 'package:aei_map_mobile/features/map_screen/repository/map_screen_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class MapBloc extends BlocProvider {
  final MapScreenRepository _mapScreenRepository = MapScreenRepository();
  BehaviorSubject <Floor> roomList = BehaviorSubject();
  BehaviorSubject <List<int>> floorList = BehaviorSubject();
  BehaviorSubject <AllPaths> pathList = BehaviorSubject();
  //BehaviorSubject <String> liftToFloor = BehaviorSubject();

  getFloorsId(BuildContext context) async => await _mapScreenRepository.getFloorsId(context).then((value) => floorList.sink.add(value));

  getRoomList(BuildContext context, int floorNumber) => _mapScreenRepository.listWithRooms(context, floorNumber).then((value) => roomList.sink.add(value));

  getPathsList(BuildContext context, int floorNumber) => _mapScreenRepository.listWithPath(context, floorNumber).then((value) => pathList.sink.add(value));

  String getFloorToUseLift (AllPaths _paths){
      return _paths.path.last.floorId;
  }

  List<PathModel> filter (List<PathModel> paths, String title) {
    return paths.where((element) => element.floorId == title).toList();
  }

    @override
  void dispose() {
    roomList.close();
    floorList.close();
    pathList.close();
    //liftToFloor.close();
  }
}