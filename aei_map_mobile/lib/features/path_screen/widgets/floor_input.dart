import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FloorInput extends StatelessWidget {
  final Function onChanged;
  const FloorInput({Key key, this.onChanged}) : super(key: key);

  @override
  Widget build(BuildContext context) {
   return Padding(
     padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 10.0),
     child: Container(
       decoration: BoxDecoration(
         color: Colors.white,
           border: Border.all(color: Colors.white),
         borderRadius: BorderRadius.circular(30)
       ),
       child: TextFormField(
         decoration: const InputDecoration(
             hintText: 'Floor',
             focusedBorder: InputBorder.none,
             enabledBorder: InputBorder.none,
             errorBorder: InputBorder.none,
             contentPadding: EdgeInsets.only(top: 2.0, left: 10)),
         keyboardType: TextInputType.number,
         onChanged: onChanged,
       ),
     ),
   );
  }
}