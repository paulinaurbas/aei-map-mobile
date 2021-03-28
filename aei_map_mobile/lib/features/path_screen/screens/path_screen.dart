import 'package:aei_map_mobile/features/path_screen/bloc/path_bloc.dart';
import 'package:aei_map_mobile/features/path_screen/widgets/floor_input.dart';
import 'package:aei_map_mobile/features/path_screen/widgets/room_number_input.dart';
import 'package:aei_map_mobile/styles/app_strings.dart';
import 'package:aei_map_mobile/styles/widgets/aei_map_button.dart';
import 'package:flutter/material.dart';

class PathScreen extends StatelessWidget {
  final PathBloc _pathBloc = PathBloc();

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        getTitleWidget(appStrings['startPoint']),
        FloorInput(onChanged: _pathBloc.changeStartPointFloor),
        RoomNumberInput(onChanged: _pathBloc.changeStartPointRoomNumber,),
        getTitleWidget(appStrings['endPoint']),
        FloorInput(onChanged: _pathBloc.changeEndPointFloor),
        RoomNumberInput(onChanged: _pathBloc.changeEndPointRoomNumber,),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: AeiMapButton(buttonDescription: appStrings['findPath'], onPressed: (){
            _pathBloc.findPathBetweenPoints();
          },),
        ),
      ],
    );
  }

  Widget getTitleWidget(String description) => Padding(
    padding: const EdgeInsets.only(left: 25, right: 25, top: 12, bottom: 12),
    child: Align(
      alignment: Alignment.topLeft,
      child: Text(description,
      style: TextStyle(fontSize: 16),),
    ),
  );

}
