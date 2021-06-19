import 'package:aei_map_mobile/features/map_screen/models/all_paths.dart';
import 'package:aei_map_mobile/features/path_screen/repository/path_screen_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PathBloc extends BlocProvider {
  final PathScreenRepository _pathScreenRepository = PathScreenRepository();

  final BehaviorSubject<String> _startPointRoomNumber =
      BehaviorSubject<String>();
  final BehaviorSubject<String> _endPointRoomNumber = BehaviorSubject<String>();
  final BehaviorSubject<AllPaths> answerFromBackend =
      BehaviorSubject<AllPaths>();
  TextEditingController inputStartPointController = TextEditingController();
  TextEditingController inputEndPointController = TextEditingController();

  Function(String) get changeStartPointRoomNumber =>
      _startPointRoomNumber.sink.add;

  Function(String) get changeEndPointRoomNumber => _endPointRoomNumber.sink.add;

  findPathBetweenPoints() {
    return _pathScreenRepository
        .findPathBetweenPoints(int.parse(_startPointRoomNumber.value),
            int.parse(_endPointRoomNumber.value))
        .then((value) => answerFromBackend.add(value))
        .onError((error, stackTrace) => answerFromBackend.addError(error));
  }

  void dispose() {
    inputEndPointController.clear();
    inputEndPointController.clear();
    _startPointRoomNumber.close();
    _endPointRoomNumber.close();
    answerFromBackend.close();
  }
}
