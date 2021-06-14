import 'dart:developer';

import 'package:aei_map_mobile/features/filter_screen/bloc/filter_bloc.dart';
import 'package:aei_map_mobile/features/filter_screen/model/filter.dart';
import 'package:aei_map_mobile/features/filter_screen/widgets/filter_selection.dart';
import 'package:aei_map_mobile/styles/widgets/aei_map_button.dart';
import 'package:flutter/material.dart';

class FilterScreen extends StatefulWidget {
  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  final FilterBloc _bloc = FilterBloc();

  // This approach does not seem to be an ideal bloc native one but it works.
  // If there is a better one, show me the way.
  var checkedFilters = new Map<int, List<int>>();

  @override
  void initState() {
    _bloc.getFiltres(context);
    _bloc.filteredRooms.stream.listen((event) {
      if (event != null) {
        // TODO: Filtered rooms are fetched. How to navigate to the map_screen
        //       with the found rooms highlighted?
        // Navigator.of(context).push(route, arguments: event)
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Filter>>(
      stream: _bloc.filters.stream,
      builder: (context, AsyncSnapshot<List<Filter>> snapshot) {
        if (snapshot.hasData)
          return _buildFiltersWidget(snapshot.data);
        else if (snapshot.hasError)
          return _buildErrorWidget(snapshot.error);
        else
          return _buildLoadingWidget();
      },
    );
  }

  Widget _buildFiltersWidget(List<Filter> filters) {
    for (var filter in filters) checkedFilters[filter.name.id] = [];

    return SingleChildScrollView(
        physics: ScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ListView.builder(
                shrinkWrap: true,
                itemCount: filters.length,
                itemBuilder: (BuildContext context, int index) {
                  return FilterSelection(
                      onChanged: (filterValue) => {
                            if (checkedFilters[filters[index].name.id]
                                .contains(filterValue))
                              checkedFilters[filters[index].name.id]
                                  .remove(filterValue)
                            else
                              checkedFilters[filters[index].name.id]
                                  .add(filterValue),
                            _bloc.changeFilters(checkedFilters)
                          },
                      filter: filters[index]);
                }),
            AeiMapButton(
              buttonDescription: 'Find matching rooms',
              onPressed: () {
                _bloc.getFilteredRooms(context);
              },
            )
          ],
        ));
  }

  Widget _buildLoadingWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [CircularProgressIndicator()])
    ]);
  }

  Widget _buildErrorWidget(String error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Error occured: $error',
              style: TextStyle(fontSize: 30, color: Colors.white)),
        ])
      ],
    );
  }
}
