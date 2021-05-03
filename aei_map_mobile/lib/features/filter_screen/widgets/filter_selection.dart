import 'package:flutter/widgets.dart';
import 'package:aei_map_mobile/features/filter_screen/model/filter.dart';
import 'package:flutter/material.dart';

class FilterSelection extends StatelessWidget {
  final Function onChanged;
  final Filter filter;

  const FilterSelection({Key key, this.onChanged, this.filter})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 50,
        child: Column(children: [
      Center(child: Text('${filter.name.name}')),
      ListView.builder(
          padding: const EdgeInsets.all(4),
          shrinkWrap: true,
          itemCount: filter.possibleValues.length,
          itemBuilder: (BuildContext context, int index) {
            return Row(
              children: [
                Checkbox(
                  // value: _checkbox,
                  value: true,
                  // onChanged: (value) {
                  //   setState(() {
                  //     _checkbox = !_checkbox;
                  //   });
                  // },
                ),
                Text('${filter.possibleValues[index].name}'),
              ],
            );
          })
    ]));
  }
}
