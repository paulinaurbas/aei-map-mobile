import 'package:aei_map_mobile/features/map_screen/bloc/map_screen_bloc.dart';
import 'package:aei_map_mobile/features/map_screen/models/all_paths.dart';
import 'package:aei_map_mobile/features/map_screen/models/floor_model.dart';
import 'package:aei_map_mobile/features/map_screen/models/path_model.dart';
import 'package:aei_map_mobile/features/map_screen/models/room_model.dart';

import 'package:aei_map_mobile/styles/app_colors.dart';
import 'package:aei_map_mobile/styles/app_strings.dart';
import 'package:aei_map_mobile/styles/widgets/aei_map_button.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:aei_map_mobile/features/map_screen/widgets/map_render_wtih_lib.dart';

class MapScreen extends StatefulWidget {
  final bool isScreenWithPath;

  const MapScreen({Key key, this.isScreenWithPath}) : super(key: key);

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Image image;
  Size _imageSize;
  MapBloc _mapBloc = MapBloc();
  int floorNumber = 0;
  List<int> floors;
  AllPaths _paths;
  List<PathModel> _pathForFloor;
  String liftToFloor;
  bool nextButtonPressed = false;
  bool previousButtonPressed = false;

  void _initializeVision() async {
    await _getImage();
  }

  Future<Image> _getImage() async {
    image = new Image.asset('assets/images/aeiMap.png');
    Completer<ImageInfo> completer = new Completer<ImageInfo>();
    image.image
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info);
      setState(() {
        _imageSize =
            Size(info.image.width.toDouble(), info.image.height.toDouble());
      });
    }));
    return image;
  }

  @override
  void initState() {
    super.initState();
    _initializeVision();
    _mapBloc.getFloorsId(context);
    _mapBloc.getPathsList(context, floorNumber);
    if (widget.isScreenWithPath == true) {
      _mapBloc.pathList.stream.listen((event) {
        if (event != null) {
          _paths = event;
          _pathForFloor = _mapBloc.filter(_paths.path, floorNumber.toString());
          setState(() {
            liftToFloor = _mapBloc.getFloorToUseLift(_paths);
          });
        }
      });
    }
    _mapBloc.floorList.stream.listen((event) {
      if (event != null) {
        floors = event;
        _mapBloc.getRoomList(context, event.first);
        if (widget.isScreenWithPath == true) {
          _pathForFloor = _mapBloc.filter(_paths?.path, floorNumber.toString());
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return _imageSize != null
        ? Stack(
            children: <Widget>[
              _getMapTitle,
              if (widget.isScreenWithPath == true) _getLiftTitle,
              StreamBuilder<Floor>(
                  stream: _mapBloc.roomList.stream,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (floorNumber != 0) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          setState(() {
                            nextButtonPressed = false;
                            previousButtonPressed = false;
                          });
                        });
                      }
                      return _getDrawnMap(snapshot.data.rooms);
                    } else {
                      return _getIndicator;
                    }
                  }),
              if (floorNumber < floors.length) _getNextBottomButton,
              if (floorNumber > 0) _getPrevoiusBottomButton
            ],
          )
        : _getIndicator;
  }

  Widget get _getIndicator => Container(
        color: Colors.black26,
        child: Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(
                appColors['primary_app_color']),
          ),
        ),
      );

  Widget get _getLiftTitle => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 85.0),
          child: Text('Take the elevator to the $liftToFloor floor',
              style: TextStyle(fontSize: 18)),
        ),
      );

  Widget get _getMapTitle => Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.only(top: 50.0),
          child: Text('Floor: $floorNumber', style: TextStyle(fontSize: 23)),
        ),
      );

  Widget _getDrawnMap(List<RoomModel> listWithRooms) => Center(
        child: Container(
          width: double.maxFinite,
          color: Colors.black,
          child: CustomPaint(
            foregroundPainter: RenderMap(_imageSize,
                MediaQuery.of(context).size, listWithRooms, _pathForFloor),
            child: AspectRatio(
              aspectRatio: _imageSize.aspectRatio,
              child: image,
            ),
          ),
        ),
      );

  Widget get _getNextBottomButton {
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 40.0, right: 20),
        child: AeiMapButton(
          buttonDescription: appStrings['nextFloor'],
          onPressed: !nextButtonPressed
              ? () {
                  setState(() {
                    nextButtonPressed = true;
                    floorNumber++;
                  });
                  _mapBloc.getRoomList(context, floorNumber);
                  if (widget.isScreenWithPath)
                    _pathForFloor =
                        _mapBloc.filter(_paths?.path, floorNumber.toString());
                }
              : null,
        ),
      ),
    );
  }

  Widget get _getPrevoiusBottomButton => Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 40.0, left: 20),
          child: AeiMapButton(
            buttonDescription: appStrings['previousFloor'],
            onPressed: !previousButtonPressed
                ? () {
                    setState(() {
                      previousButtonPressed = true;
                      floorNumber--;
                    });
                    _mapBloc.getRoomList(context, floorNumber);
                    if (widget.isScreenWithPath)
                      _pathForFloor =
                          _mapBloc.filter(_paths.path, floorNumber.toString());
                  }
                : null,
          ),
        ),
      );
}
