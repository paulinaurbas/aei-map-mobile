import 'dart:ui';

import 'package:aei_map_mobile/features/map_screen/models/path_model.dart';
import 'package:aei_map_mobile/features/map_screen/models/room_model.dart';
import 'package:aei_map_mobile/styles/app_colors.dart';
import 'package:flutter/material.dart';

class RenderMap extends CustomPainter {
  RenderMap(
      this.absoluteImageSize, this.phoneSize, this._roomModel, this._pathModel);

  final Size phoneSize;
  final List<RoomModel> _roomModel;
  final List<PathModel> _pathModel;
  final Size absoluteImageSize;
  double avgHeight = 0;
  double avgWeight = 0;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint roomsPainter = Paint();
    roomsPainter.color = appColors['primary_app_color'];

    Path drawRoomsOnMap = Path();
    _drawRooms(drawRoomsOnMap, scaleX, scaleY);

    Path pathToRoom = Path();
    final Paint pathLine = Paint()
      ..style = PaintingStyle.stroke
      ..color = appColors['way_color']
      ..strokeWidth = 2.0;

    if (_pathModel != null) _drawPathToRoom(pathToRoom, scaleX, scaleY);
    canvas.drawPath(drawRoomsOnMap, roomsPainter);
    if (_pathModel != null) canvas.drawPath(pathToRoom, pathLine);
    _drawRoomsNumber(canvas, scaleX, scaleY);
  }

  void _drawRooms(Path drawRoomsOnMap, double scaleX, double scaleY) {
    for (final element in _roomModel) {
      drawRoomsOnMap.moveTo(element.listOfNodes.first.x * scaleX,
          element.listOfNodes.first.y * scaleY);
      for (final node in element.listOfNodes) {
        drawRoomsOnMap.lineTo(node.x * scaleX, node.y * scaleY);
      }
      drawRoomsOnMap.lineTo(element.listOfNodes.first.x * scaleX,
          element.listOfNodes.first.y * scaleY);
    }
    drawRoomsOnMap.close();
  }

  void _drawRoomsNumber(Canvas canvas, double scaleX, double scaleY) {
    for (final element in _roomModel) {
      for (final node in element.listOfNodes) {
        avgHeight += node.y;
        avgWeight += node.x;
      }
      avgHeight = avgHeight / element.listOfNodes.length;
      avgWeight = avgWeight / element.listOfNodes.length;
      for (int i = 0; i < element.room.length; i++) {
        _paintText(
            canvas, Size(avgWeight * scaleY, avgHeight * scaleX), element.roomNumber.toString());
      }
      avgHeight = 0;
      avgWeight = 0;
    }
  }

  void _drawPathToRoom(Path path, double scaleX, double scaleY) {
    for (final element in _pathModel) {
      path.moveTo(element.path.first.x * scaleX, element.path.first.y * scaleY);
      for (final node in element.path) {
        path.lineTo(node.x * scaleX, node.y * scaleY);
        path.moveTo(node.x * scaleX, node.y * scaleY);
      }
    }
    path.close();
  }

  void _paintText(Canvas canvas, Size size, String roomNumber) {
    final textSpan = TextSpan(
        text: roomNumber, style: TextStyle(color: Colors.black, fontSize: 12));
    final textPainter = TextPainter(
      text: textSpan,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      Offset((size.width - textPainter.width * 0.5),
          (size.height - textPainter.height * 0.5)),
    );
  }

  @override
  bool shouldRepaint(RenderMap oldDelegate) {
    return false;
  }
}
