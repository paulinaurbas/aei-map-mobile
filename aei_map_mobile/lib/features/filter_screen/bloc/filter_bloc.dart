import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';
import 'package:aei_map_mobile/features/filter_screen/repository/filter_screen_repository.dart';
import 'package:aei_map_mobile/features/filter_screen/model/model.dart';

class FilterBloc extends BlocProvider {
  final FilterScreenRepository _repository = FilterScreenRepository();

  final BehaviorSubject<FiltersGetResponse> _filtersGetResponse =
      BehaviorSubject();
  final BehaviorSubject<List<Filter>> _checkedFilters = BehaviorSubject();
  final BehaviorSubject<FilteredRoomsGetResponse> _filteredRoomsGetResponse =
      BehaviorSubject();

  getFiltres() async {
    FiltersGetResponse response = await _repository.getFilters();
    _filtersGetResponse.sink.add(response);
  }

  BehaviorSubject<FiltersGetResponse> get filtersGetResponse =>
      _filtersGetResponse;

  Function(List<Filter>) get changeFilters => _checkedFilters.sink.add;

  getFilteredRooms() async {
    FilteredRoomsGetResponse response =
        await _repository.getFilteredRooms(_checkedFilters.valueWrapper.value);
    _filteredRoomsGetResponse.sink.add(response);
  }

  BehaviorSubject<FilteredRoomsGetResponse> get filteredRoomsGetResponse =>
      _filteredRoomsGetResponse;

  @override
  void dispose() {
    _filtersGetResponse.close();
    _checkedFilters.close();
    _filteredRoomsGetResponse.close();
  }
}
