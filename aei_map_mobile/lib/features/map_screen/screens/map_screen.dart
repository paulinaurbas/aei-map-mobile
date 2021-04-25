import 'package:aei_map_mobile/features/map_screen/bloc/map_screen_bloc.dart';
import 'package:aei_map_mobile/features/map_screen/models/room_model.dart';
import 'package:aei_map_mobile/styles/app_colors.dart';
import 'package:aei_map_mobile/styles/app_strings.dart';
import 'package:aei_map_mobile/styles/widgets/aei_map_button.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:async';
import 'package:aei_map_mobile/features/map_screen/widgets/map_render_wtih_lib.dart';

class MapScreen extends StatefulWidget {
  MapScreen();

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  Image image;
  Size _imageSize;
  MapBloc mapBloc = MapBloc();
  int floorNumber = 0;
  List <int> floors;

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
  }

  @override
  void initState() {
    _initializeVision();
    mapBloc.getFloorsId(context);

    mapBloc.floorList.stream.listen((event) {
      if(event != null){
        floors = event;
        mapBloc.getRoomList(context, event.first);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _imageSize != null
        ? StreamBuilder<List<RoomModel>>(
            stream: mapBloc.roomList.stream,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Stack(
                  children: <Widget>[
                    getMapTitle,
                    getDrawnMap(snapshot.data),
                    if(floorNumber < floors.length) getNextBottomButton,
                    if(floorNumber > 0) getPrevoiusBottomButton
                  ],
                );
              } else
                return getIndicator;
            })
        : getIndicator;
  }

  Widget get getIndicator =>  Container(
    color: Colors.black26,
    child: Center(
      child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(
            appColors['primary_app_color']),
      ),
    ),
  );

  Widget get getMapTitle =>  Align(
    alignment: Alignment.topCenter,
    child: Padding(
      padding: const EdgeInsets.only(top: 70.0),
      child: Text('Floor: $floorNumber', style: TextStyle(fontSize: 25)),
    ),
  );

  Widget getDrawnMap(List<RoomModel> listWithRooms) => Center(
    child: Container(
      width: double.maxFinite,
      color: Colors.black,
      child: CustomPaint(
        foregroundPainter: RenderMap(_imageSize,
            MediaQuery.of(context).size, listWithRooms),
        child: AspectRatio(
          aspectRatio: _imageSize.aspectRatio,
          child: image,
        ),
      ),
    ),
  );

  Widget get getNextBottomButton => Align(
    alignment: Alignment.bottomRight,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 40.0, right: 20),
      child: AeiMapButton(
        buttonDescription: appStrings['nextFloor'],
        onPressed: () {
          setState(() {
            floorNumber++;
          });
          mapBloc.getRoomList(context, floorNumber);
        },
      ),
    ),
  );

  Widget get getPrevoiusBottomButton => Align(
    alignment: Alignment.bottomLeft,
    child: Padding(
      padding: const EdgeInsets.only(bottom: 40.0, left: 20),
      child: AeiMapButton(
        buttonDescription: appStrings['previousFloor'],
        onPressed: () {
          setState(() {
            floorNumber--;
          });
          mapBloc.getRoomList(context, floorNumber);
        },
      ),
    ),
  );

}
