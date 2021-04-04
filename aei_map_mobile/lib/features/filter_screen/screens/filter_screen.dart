import 'package:aei_map_mobile/features/filter_screen/bloc/filter_bloc.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final FilterBloc _bloc = FilterBloc();

  @override
  void initState() {
    super.initState();
    _bloc.getFiltres();
    // TODO: Halp :')
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('filter',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ])
      ],
    );
  }
}
