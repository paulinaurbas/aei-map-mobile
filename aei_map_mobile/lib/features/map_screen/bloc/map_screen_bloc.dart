import 'dart:async';

import 'package:aei_map_mobile/features/map_screen/models/all_paths.dart';
import 'package:aei_map_mobile/features/map_screen/models/floor_model.dart';
import 'package:aei_map_mobile/features/map_screen/models/path_model.dart';
import 'package:aei_map_mobile/features/map_screen/repository/map_screen_repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

// ignore: must_be_immutable
class MapBloc extends BlocProvider {
  final MapScreenRepository _mapScreenRepository = MapScreenRepository();
  PublishSubject<Floor> roomList = PublishSubject();
  BehaviorSubject<List<int>> floorList = BehaviorSubject();

  getFloorsId(BuildContext context) async => await _mapScreenRepository
      .getFloorsId(context)
      .then((value) => floorList.sink.add(value));

  getRoomList(BuildContext context, int floorNumber) {
    roomList.sink.add(null);
    return _mapScreenRepository
        .listWithRooms(context, floorNumber)
        .then((value) => roomList.sink.add(value));
  }


  String getFloorToUseLift(AllPaths _paths) {
    return _paths.path.last.floorId.toString();
  }

  List<PathModel> filter(List<PathModel> paths, int title) {
    return paths?.where((element) => element.floorId == title)?.toList();
  }

  @override
  void dispose() {
    roomList.close();
    floorList.close();
  }
}
