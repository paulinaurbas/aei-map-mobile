import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';
import 'package:aei_map_mobile/features/filter_screen/repository/filter_screen_repository.dart';
import 'package:aei_map_mobile/features/filter_screen/model/filter.dart';

class FilterBloc extends BlocProvider {
  final FilterScreenRepository _repository = FilterScreenRepository();

  final BehaviorSubject<List<Filter>> _filters = BehaviorSubject();
  final BehaviorSubject<List<Filter>> _checkedFilters = BehaviorSubject();
  final BehaviorSubject<List<int>> _filteredRooms = BehaviorSubject();

  BehaviorSubject<List<Filter>> get filters => _filters;
  BehaviorSubject<List<int>> get filteredRooms => _filteredRooms;

  Function(List<Filter>) get changeFilters => _checkedFilters.sink.add;

  getFiltres() async {
    _repository.getFilters().then((filters) => _filters.sink.add(filters));
  }

  getFilteredRooms() async {
    _repository
        .getFilteredRooms(_checkedFilters.valueWrapper.value)
        .then((filteredRooms) => _filteredRooms.sink.add(filteredRooms));
  }

  @override
  void dispose() {
    _filters.close();
    _checkedFilters.close();
    _filteredRooms.close();
  }
}
