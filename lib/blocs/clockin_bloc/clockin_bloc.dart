import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../Networks/models/clockin_model.dart';
import '../../Networks/services/clockin_services.dart';

part 'clockin_event.dart';
part 'clockin_state.dart';

class ClockinBloc extends Bloc<ClockinEvent, ClockinListState> {
  final ClockInServices _services = ClockInServices();

  ClockinBloc() : super(const ClockinListState()) {
    on<LoadClockInList>((event, emit) async {
      emit(state.copyWith(status: ListStatus.loading));
      final res = await _services.getClockInReport();
      emit(state.copyWith(
        data: res.results,
        totalHours: res.totalHours,
        status: ListStatus.loaded,
      ));
    });
  }
}
