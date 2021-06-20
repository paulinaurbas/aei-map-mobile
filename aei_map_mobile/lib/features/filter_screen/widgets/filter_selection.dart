import 'package:aei_map_mobile/features/filter_screen/model/filter.dart';
import 'package:aei_map_mobile/styles/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FilterSelection extends StatefulWidget {
  FilterSelection({Key key, this.onChanged, this.filter}) : super(key: key);
  final Function onChanged;
  final Filter filter;

  @override
  _FilterSelectionState createState() => _FilterSelectionState();
}

class _FilterSelectionState extends State<FilterSelection> {
  List<bool> _checkedCheckbox = [];

  @override
  void initState() {
    _checkedCheckbox =
        List<bool>.filled(widget.filter.possibleValues.length, false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData(unselectedWidgetColor: Colors.white),
        child: Container(
            child: Column(children: [
          Center(
              child: Text(
            '${widget.filter.name}',
            style: TextStyle(fontSize: 25, letterSpacing: 0.40),
          )),
          ListView.builder(
              shrinkWrap: true,
              itemCount: widget.filter.possibleValues.length,
              itemBuilder: (BuildContext context, int index) {
                return Row(
                  children: [
                    Checkbox(
                      value: _checkedCheckbox[index],
                      activeColor: appColors["primary_app_color"],
                      onChanged: (value) {
                        setState(() {
                          _checkedCheckbox[index] = !_checkedCheckbox[index];
                        });
                        widget
                            .onChanged(widget.filter.possibleValues[index].id);
                      },
                    ),
                    Text('${widget.filter.possibleValues[index].name}'),
                  ],
                );
              })
        ])));
  }
}
