import 'dart:ui';
import 'package:aei_map_mobile/features/map_screen/models/path_model.dart';
import 'package:aei_map_mobile/features/map_screen/models/room_model.dart';
import 'package:aei_map_mobile/styles/app_colors.dart';
import 'package:flutter/material.dart';

class RenderMap extends CustomPainter {
  RenderMap(this.absoluteImageSize, this.phoneSize, this._roomModel, this._pathModel);
  final Size phoneSize;
  final List<RoomModel> _roomModel;
  final List<PathModel> _pathModel;
  final Size absoluteImageSize;

  final _textPainter = TextPainter(textDirection: TextDirection.ltr);

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint();
    paint.color = appColors['primary_app_color'];

    Path path_0 = Path();

    for(final element in _roomModel){
      path_0.moveTo(element.listOfNodes.first.x * scaleX, element.listOfNodes.first.y * scaleY);
      for(final node in element.listOfNodes){
        path_0.lineTo(node.x * scaleX, node.y * scaleY);
        //path_0.moveTo(node.x * scaleX, node.y * scaleY);
      }
      path_0.lineTo(element.listOfNodes.first.x * scaleX, element.listOfNodes.first.y* scaleY);
    }

    path_0.close();

    Path path_1 = Path();
    final Paint paintLine = Paint()
      ..style = PaintingStyle.stroke
      ..color = appColors['way_color']
      ..strokeWidth = 2.0;

    for(final element in _pathModel){
      path_1.moveTo(element.path.first.x * scaleX, element.path.first.y * scaleY);
      for(final node in element.path){
        path_1.lineTo(node.x * scaleX, node.y * scaleY);
        path_1.moveTo(node.x * scaleX, node.y * scaleY);
      }
    }
    path_1.close();

    canvas.drawPath(path_0, paint);
    canvas.drawPath(path_1, paintLine);
  }

  void _drawLetter(Canvas canvas, String letter, x, y) {
    _textPainter.text = TextSpan(text: letter,);
    _textPainter.layout(
      minWidth: 0,
      maxWidth: double.maxFinite,
    );
    final double d = _textPainter.width;

    _textPainter.paint(canvas, Offset(x, y));
    canvas.translate(d, 0);
  }

  @override
  bool shouldRepaint(RenderMap oldDelegate) {
    return false;
  }
}