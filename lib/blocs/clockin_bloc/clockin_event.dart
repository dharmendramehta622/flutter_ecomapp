part of 'clockin_bloc.dart';

sealed class ClockinEvent extends Equatable {
  const ClockinEvent();

  @override
  List<Object> get props => [];
}


class LoadClockInList extends ClockinEvent {
  final PaginationModel model;

  LoadClockInList({PaginationModel? model})
      : model = model ?? PaginationModel(limit: 10, offset: 0);
}