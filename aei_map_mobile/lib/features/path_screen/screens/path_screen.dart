import 'package:aei_map_mobile/features/path_screen/bloc/path_bloc.dart';
import 'package:aei_map_mobile/features/path_screen/widgets/room_number_input.dart';
import 'package:aei_map_mobile/styles/app_strings.dart';
import 'package:aei_map_mobile/styles/widgets/aei_map_button.dart';
import 'package:aei_map_mobile/styles/widgets/progress_indicator.dart';
import 'package:flutter/material.dart';

class PathScreen extends StatefulWidget {
  @override
  _PathScreenState createState() => _PathScreenState();
}

class _PathScreenState extends State<PathScreen> {
  final PathBloc _pathBloc = PathBloc();
  bool isLoading = false;

  @override
  void dispose() {
    _pathBloc.inputStartPointController.dispose();
    _pathBloc.inputEndPointController.dispose();
    _pathBloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      width: double.infinity,
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        onPanDown: (_) => FocusScope.of(context).unfocus(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Visibility(
              child: getIndicator,
              maintainSize: true,
              maintainAnimation: true,
              maintainState: true,
              visible: isLoading,
            ),
            getTitleWidget(appStrings['startPoint']),
            RoomNumberInput(
              controller: _pathBloc.inputStartPointController,
              onChanged: _pathBloc.changeStartPointRoomNumber,
            ),
            getTitleWidget(appStrings['endPoint']),
            RoomNumberInput(
              controller: _pathBloc.inputEndPointController,
              onChanged: _pathBloc.changeEndPointRoomNumber,
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: AeiMapButton(
                buttonDescription: appStrings['findPath'],
                onPressed: _pathBloc.inputStartPointController.value.text.isNotEmpty && _pathBloc.inputEndPointController.value.text.isNotEmpty ? () {
                  setState(() {
                    isLoading = true;
                  });
                  FocusScope.of(context).unfocus();
                  _pathBloc.findPathBetweenPoints();
                } : null,
              ),
            ),
          ],
        ),
      ),
    );
  }


  @override
  void initState() {
    super.initState();
    _pathBloc.answerFromBackend.listen((value) {
      Navigator.pushNamed(context, '/MapScreenWithPath', arguments: value);
      setState(() {
        isLoading = false;
      });
    });

  }

  Widget getTitleWidget(String description) => Padding(
        padding:
            const EdgeInsets.only(left: 25, right: 25, top: 12, bottom: 12),
        child: Align(
          alignment: Alignment.topLeft,
          child: Text(
            description,
            style: TextStyle(fontSize: 16),
          ),
        ),
      );
}
