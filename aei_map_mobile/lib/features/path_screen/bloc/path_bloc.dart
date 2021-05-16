import 'package:aei_map_mobile/features/path_screen/repository/path_screen_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

class PathBloc extends BlocProvider {
  final PathScreenRepository _pathScreenRepository = PathScreenRepository();

  final BehaviorSubject<String> _startPointFloor = BehaviorSubject<String>();
  final BehaviorSubject<String> _startPointRoomNumber = BehaviorSubject<String>();
  final BehaviorSubject<String> _endPointFloor = BehaviorSubject<String>();
  final BehaviorSubject<String> _endPointRoomNumber = BehaviorSubject<String>();
  final BehaviorSubject<String> _answerFromBackend = BehaviorSubject<String>();

  Function(String) get changeStartPointFloor => _startPointFloor.sink.add;

  Function(String) get changeStartPointRoomNumber => _startPointRoomNumber.sink.add;

  Function(String) get changeEndPointFloor => _endPointFloor.sink.add;

  Function(String) get changeEndPointRoomNumber => _endPointRoomNumber.sink.add;

  findPathBetweenPoints(){
    //TODO: impelment call to backend
    return _pathScreenRepository.findPathBetweenPoints();
  }

  @override
  void dispose() {
    _startPointFloor.close();
    _startPointRoomNumber.close();
    _endPointFloor.close();
    _endPointRoomNumber.close();
    _answerFromBackend.close();
  }
}