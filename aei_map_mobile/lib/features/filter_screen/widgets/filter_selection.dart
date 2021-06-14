import 'package:flutter/widgets.dart';
import 'package:aei_map_mobile/features/filter_screen/model/filter.dart';
import 'package:flutter/material.dart';

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
    return Container(
        // height: 50,
        child: Column(children: [
      Center(child: Text('${widget.filter.name}')),
      ListView.builder(
          shrinkWrap: true,
          itemCount: widget.filter.possibleValues.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Checkbox(
                  value: _checkedCheckbox[index],
                  onChanged: (value) {
                    setState(() {
                      _checkedCheckbox[index] = !_checkedCheckbox[index];
                    });
                    widget.onChanged(widget.filter.possibleValues[index].id);
                  },
                ),
                Text('${widget.filter.possibleValues[index].name}'),
              ],
            );
          })
    ]));
  }
}
