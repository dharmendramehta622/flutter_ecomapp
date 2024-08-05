part of 'clockin_status_bloc.dart';

// sealed class ClockinStatusState extends Equatable {
//   const ClockinStatusState();
  
//   @override
//   List<Object> get props => [];
// }

// final class ClockinStatusInitial extends ClockinStatusState {}


enum ClockInStatus{
  initial,
  clockedIn,
  clockedOut,
  loading,
}

class ClockinStatusState<T> extends Equatable {
  final ClockInModel? data;
  final double totalHours;
  final ClockInStatus status;

  const ClockinStatusState({
    this.data ,
    this.totalHours = 0,
    this.status = ClockInStatus.initial,  
  });

  @override
  List<Object?> get props => [data,  status, totalHours];

 

  ClockinStatusState<T> copyWith({
    ClockInModel? data,
    double? totalHours,
    ClockInStatus? status, 
  }) {
    return ClockinStatusState<T>(
      data: data ?? this.data,
      totalHours: totalHours ?? this.totalHours,
      status: status ?? this.status, 
    );
  }
}
