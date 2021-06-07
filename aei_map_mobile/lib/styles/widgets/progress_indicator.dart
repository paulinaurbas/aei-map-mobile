import 'package:flutter/material.dart';

import '../app_colors.dart';

Widget get getIndicator => Container(
  color: appColors["background_color"],
  child: Center(
    child: CircularProgressIndicator(
      backgroundColor: appColors["background_color"],
      valueColor: new AlwaysStoppedAnimation<Color>(
          appColors['primary_app_color']),
    ),
  ),
);