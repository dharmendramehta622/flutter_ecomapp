import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'clockin_event.dart';
part 'clockin_state.dart';

class ClockinBloc extends Bloc<ClockinEvent, ClockinState> {
  ClockinBloc() : super(ClockinInitial()) {
    on<ClockinEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
