import 'dart:ui';
import 'package:aei_map_mobile/features/map_screen/models/path_model.dart';
import 'package:aei_map_mobile/features/map_screen/models/room_model.dart';
import 'package:aei_map_mobile/styles/app_colors.dart';
import 'package:flutter/material.dart';

class RenderMap extends CustomPainter {
  RenderMap(this.absoluteImageSize, this.phoneSize, this._roomModel,
      this._pathModel, this._filteredRoomsModel);

  final Size phoneSize;
  final List<RoomModel> _roomModel;
  final List<PathModel> _pathModel;
  final List<int> _filteredRoomsModel;
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

    final Paint pathLineStroke = Paint()
      ..style = PaintingStyle.stroke
      ..color = appColors['background_color']
      ..strokeWidth = 0.5;

    if (_pathModel != null && _pathModel.isNotEmpty && _pathModel.length > 0) _drawPathToRoom(canvas, pathToRoom, scaleX, scaleY);

    canvas.drawPath(drawRoomsOnMap, roomsPainter);
    canvas.drawPath(drawRoomsOnMap, pathLineStroke);

    if (_pathModel != null && _pathModel.isNotEmpty && _pathModel.length > 0) canvas.drawPath(pathToRoom, pathLine);

    if (_filteredRoomsModel != null) {
      final Paint filteredRoomsPainter = Paint()
        ..style = PaintingStyle.fill
        ..color = appColors['filtered_room_color'];
      Path drawFilteredRoomsOnMap = Path();
      _drawRooms(drawFilteredRoomsOnMap, scaleX, scaleY, filtered: true);
      canvas.drawPath(drawFilteredRoomsOnMap, filteredRoomsPainter);
    }

    if (_pathModel != null && _pathModel.isNotEmpty && _pathModel.length > 0)
      drawIcon(canvas, (_pathModel.last.path.last.x) * scaleX,
          _pathModel.last.path.last.y * scaleY);
    _drawRoomsNumber(canvas, scaleX, scaleY);
  }

  void _drawRooms(Path drawRoomsOnMap, double scaleX, double scaleY,
      {bool filtered = false}) {
    for (final element in filtered
        ? _roomModel
            .where((element) => _filteredRoomsModel.contains(element.id))
            .toList()
        : _roomModel) {
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
            canvas,
            Size(avgWeight * scaleY, avgHeight * scaleX),
            (element.roomNumber > 0
                ? element.roomNumber.toString()
                : element.room.toString() +
                    ' (' +
                    element.roomNumber.toString() +
                    ')'));
      }
      avgHeight = 0;
      avgWeight = 0;
    }
  }

  void _drawPathToRoom(Canvas canvas, Path path, double scaleX, double scaleY) {
    for (final element in _pathModel) {
      if (element != null) {
        path.moveTo(
            element.path.first.x * scaleX, element.path.first.y * scaleY);
        for (final node in element.path) {
          path.lineTo(node.x * scaleX, node.y * scaleY);
          path.moveTo(node.x * scaleX, node.y * scaleY);
        }
        path.close();
      }
    }
  }

  void drawIcon(Canvas canvas, double x, double y) {
    final icon = Icons.add_location_outlined;
    TextPainter textPainter = TextPainter(textDirection: TextDirection.ltr);
    textPainter.text = TextSpan(
      text: String.fromCharCode(icon.codePoint),
      style: TextStyle(
        color: appColors['way_color'],
        fontSize: 12,
        fontFamily: icon.fontFamily,
        package:
            icon.fontPackage, // This line is mandatory for external icon packs
      ),
    );
    textPainter.layout();
    textPainter.paint(canvas, Offset(x - 12, y - 12));
  }

  void _paintText(Canvas canvas, Size size, String roomNumber) {
    final textSpan = TextSpan(
        text: roomNumber, style: TextStyle(color: Colors.black, fontSize: 10));
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
