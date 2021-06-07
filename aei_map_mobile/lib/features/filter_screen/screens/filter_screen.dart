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
  List<Filter> selectedFilters;
  var checkedFilters = new Set();
  var checkedFilters2 = new Map();

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
        if (snapshot.hasData) {
          return _buildFiltersWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildFiltersWidget(List<Filter> filters) {
    for (var filter in filters) {
      checkedFilters2[filter.name.id] = [];
    }

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
                      // TODO: onChanged() should update _bloc._checkedFilters.
                      //       But how? It could add a map with FilterID:ValueID
                      //       or delete such map if unchecked.
                      onChanged: (filterValue) => {
                        // final checkedValues = checkedFilters2[filters[index].name.id];

                        // TODO: robie mape z id filtrow na array z id valuesow checkowanych i je dodaje, albo usuwam, jak juz sa (czyli sa odcheckowane)
                        var s = checkedFilters2[filters[index].name.id];
                        // _bloc.checkFilterValue(
                        //   filters[index].name.id, filterValue)
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
