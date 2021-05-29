import 'package:aei_map_mobile/styles/app_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AeiMapButton extends StatelessWidget{
  final Function onPressed;
  final String buttonDescription;

  const AeiMapButton({Key key, this.onPressed, this.buttonDescription}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      return MaterialButton(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(buttonDescription,
              style: TextStyle(fontSize: 14, color: Colors.white, letterSpacing: 0.8),),
          ),
          color: appColors['primary_app_color'],
          onPressed: onPressed,
          disabledColor: Colors.grey,
      );
  }

}