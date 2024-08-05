import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:geolocator/geolocator.dart';
import 'package:new_project/Networks/services/location_services.dart';
import '../clockin_bloc/clockin_bloc.dart';
part 'location_event.dart';
part 'location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final LocationServices _services = LocationServices();

  LocationBloc() : super(const LocationState()) {
    on<LoadLocation>((event, emit) async {
      emit(state.copyWith(status: ListStatus.loading));
      final res = await _services.determinePosition();
      emit(state.copyWith(data: res, status: ListStatus.loaded));
    });
  }
}
