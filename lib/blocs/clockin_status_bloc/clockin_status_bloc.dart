import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_project/Networks/models/clockin_model.dart';
import '../../Networks/services/clockin_services.dart';
part 'clockin_status_event.dart';
part 'clockin_status_state.dart';

class ClockinStatusBloc extends Bloc<ClockinStatusEvent, ClockinStatusState> {
  final ClockInServices _services = ClockInServices();

  ClockinStatusBloc() : super(const ClockinStatusState()) {
    on<CheckClockIn>((event, emit) async {
      emit(state.copyWith(status: ClockInStatus.loading));
      final res = await _services.getClockInStatus();
      if (res != null) {
        emit(state.copyWith(status: ClockInStatus.clockedIn, data: res));
      } else {
        emit(state.copyWith(status: ClockInStatus.clockedOut));
      }
    });
  }
}
