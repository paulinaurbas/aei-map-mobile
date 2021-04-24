import 'dart:ui';
import 'package:aei_map_mobile/features/map_screen/models/room_model.dart';
import 'package:aei_map_mobile/styles/app_colors.dart';
import 'package:flutter/material.dart';

class TextDetectorPainter extends CustomPainter {
  TextDetectorPainter(this.absoluteImageSize, this.phoneSize, this._roomModel);
  final Size phoneSize;
  final List<RoomModel> _roomModel;

  final Size absoluteImageSize;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..color = appColors['primary_app_color']
      ..strokeWidth = 2.0;

    Path path_0 = Path();

    for(final element in _roomModel){
      path_0.moveTo(element.listOfNodes.first.x * scaleX, element.listOfNodes.first.y * scaleY);
      for(final node in element.listOfNodes){
        path_0.lineTo(node.x * scaleX, node.y * scaleY);
        path_0.moveTo(node.x * scaleX, node.y * scaleY);
      }
      path_0.lineTo(element.listOfNodes.first.x * scaleX, element.listOfNodes.first.y* scaleY);
    }

    path_0.close();

    canvas.drawPath(path_0, paint);
  }


  @override
  bool shouldRepaint(TextDetectorPainter oldDelegate) {
    return true;
  }
}