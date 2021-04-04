import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/subjects.dart';
import 'package:aei_map_mobile/features/filter_screen/repository/filter_screen_repository.dart';
import 'package:aei_map_mobile/features/filter_screen/model/model.dart';

class FilterBloc extends BlocProvider {
  final FilterScreenRepository _repository = FilterScreenRepository();

  final PublishSubject<List<Filter>> _possibleFilters = PublishSubject();
  final BehaviorSubject<List<Filter>> _checkedFilters = BehaviorSubject();
  final PublishSubject<List<int>> _filteredRooms = PublishSubject();

  getFiltres() {
    _repository.getFilters().then((value) => _possibleFilters.sink.add(value));
  }

  Function(List<Filter>) get changeFilters => _checkedFilters.sink.add;

  getFilteredRooms() {
    _repository
        .getFilteredRooms(_checkedFilters.valueWrapper.value)
        .then((value) => _filteredRooms.sink.add(value));
  }

  @override
  void dispose() {
    _possibleFilters.close();
    _checkedFilters.close();
    _filteredRooms.close();
  }
}
