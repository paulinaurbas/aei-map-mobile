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

  @override
  void initState() {
    _bloc.getFiltres(context);
    _bloc.filteredRooms.stream.listen((filteredRooms) {
      if (filteredRooms != null)
        Navigator.pushNamed(context, '/MapScreenWithFilteredRooms',
            arguments: filteredRooms);
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
    _bloc.initializeCheckedFilters(filters.map((filter) => filter.id).toList());

    return SingleChildScrollView(
      physics: ScrollPhysics(),
      child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListView.builder(
                  shrinkWrap: true,
                  itemCount: filters.length,
                  itemBuilder: (BuildContext context, int index) {
                    return FilterSelection(
                        onChanged: (filterValueId) =>
                            _bloc.changeCheckedFilters(
                                filters[index].id, filterValueId),
                        filter: filters[index]);
                  }),
              AeiMapButton(
                buttonDescription: 'Find matching rooms',
                onPressed: () {
                  _bloc.getFilteredRooms(context);
                },
              )
            ],
          )),
    );
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
