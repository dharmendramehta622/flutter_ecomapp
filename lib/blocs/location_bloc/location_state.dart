part of 'location_bloc.dart';

 
 
class LocationState<T> extends Equatable {
  final Position? data;
  final ListStatus status;

  const LocationState({
    this.data ,
    this.status = ListStatus.initial,
  });

  @override
  List<Object?> get props => [ 
    data, 
    status];

  LocationState<T> copyWith({
    Position? data, 
    ListStatus? status,
  }) {
    return LocationState<T>(
      data: data ?? this.data, 
      status: status ?? this.status,
    );
  }
}