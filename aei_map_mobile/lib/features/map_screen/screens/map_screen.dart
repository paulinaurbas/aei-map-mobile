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
  final String imagePath;
  MapScreen(this.imagePath);

  @override
  _MapScreenState createState() => new _MapScreenState(imagePath);
}

class _MapScreenState extends State<MapScreen> {
  _MapScreenState(this.path);
  final String path;
  Image image;
  Size _imageSize;
  MapBloc mapBloc = MapBloc();
  String recognizedText = "Loading ...";

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
    mapBloc.getRoomList(context);
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
                    Center(
                      child: Container(
                        width: double.maxFinite,
                        color: Colors.black,
                        child: CustomPaint(
                          foregroundPainter: TextDetectorPainter(
                              _imageSize,
                              MediaQuery.of(context).size,
                              snapshot.data),
                          child: AspectRatio(
                            aspectRatio: _imageSize.aspectRatio,
                            child: image,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            bottom: 40.0, right: 20),
                        child: AeiMapButton(
                          buttonDescription: appStrings['nextFloor'],
                          onPressed: () {},
                        ),
                      ),
                    )
                  ],
                );
              } else {
                return Container(
                  color: Colors.black26,
                  child: Center(
                    child: CircularProgressIndicator(
                      valueColor: new AlwaysStoppedAnimation<Color>(
                          appColors['primary_app_color']),
                    ),
                  ),
                );
              }
            })
        : Container(
            color: Colors.black26,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: new AlwaysStoppedAnimation<Color>(
                    appColors['primary_app_color']),
              ),
            ),
          );
  }
}
