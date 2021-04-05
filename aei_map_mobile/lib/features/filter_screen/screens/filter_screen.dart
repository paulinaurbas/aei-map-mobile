import 'package:aei_map_mobile/features/filter_screen/bloc/filter_bloc.dart';
import 'package:aei_map_mobile/features/filter_screen/model/model.dart';
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
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FiltersGetResponse>(
      stream: _bloc.filters.stream,
      builder: (context, AsyncSnapshot<FiltersGetResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildFiltersWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildFiltersWidget(FiltersGetResponse filters) {
    // TODO: Build filters widgets iteratively. Get to know
    //       on how to gather input from all the filters
    //       and pass them alter to the BLoC. And when to
    //       call getFilteredRooms() AND what to do with
    //       the response :')
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('filters',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ])
      ],
    );
  }

  Widget _buildLoadingWidget() {
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text("Loading filters from API...",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black)),
        CircularProgressIndicator()
      ])
    ]);
  }

  Widget _buildErrorWidget(String error) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text('Error occured: $error',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black)),
        ])
      ],
    );
  }
}
