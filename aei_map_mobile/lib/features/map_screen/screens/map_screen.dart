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
  String recognizedText = "Loading ...";

  void _initializeVision() async {
    await _getImage();
  }
  Future<Image> _getImage() async {
    image = new Image.asset('assets/images/aeiMap.png');
    //image = new Image.network('https://i.stack.imgur.com/lkd0a.png');
    Completer<ImageInfo> completer = new Completer<ImageInfo>();
    image.image
        .resolve(new ImageConfiguration())
        .addListener(ImageStreamListener((ImageInfo info, bool _) {
      completer.complete(info);
      setState(() {
        _imageSize = Size(info.image.width.toDouble(), info.image.height.toDouble());
      });
    }));
  }

  @override
  void initState() {
    _initializeVision();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return _imageSize != null
        ? Stack(
      children: <Widget>[
        Center(
          child: Container(
            width: double.maxFinite,
            color: Colors.black,
            child: CustomPaint(
              foregroundPainter:
              TextDetectorPainter(_imageSize),
              child: AspectRatio(
                aspectRatio: _imageSize.aspectRatio,
                child: image,
              ),
            ),
          ),
        ),
      ],
    )
        : Container(
      color: Colors.black26,
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}

