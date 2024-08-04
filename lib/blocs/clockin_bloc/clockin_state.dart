part of 'clockin_bloc.dart';

enum ListStatus { initial, loading, loaded, success, created, failure }


class ClockinListState<T> extends Equatable {
  final List<T> data;
  final double totalHours;
  final bool hasReachedMax;
  final ListStatus status;
  final String message;

  const ClockinListState({
    this.data = const [],
    this.totalHours = 0,
    this.status = ListStatus.initial,
    this.message = '',
    this.hasReachedMax = false,
  });

  @override
  List<Object?> get props => [data,  status, message,hasReachedMax,totalHours];

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, publicPosts: ${data.length} } }, ''';
  }

  ClockinListState<T> copyWith({
    List<T>? data,
    double? totalHours,
    ListStatus? status,
    String? message,
    bool? hasReachedMax,
  }) {
    return ClockinListState<T>(
      data: data ?? this.data,
      totalHours: totalHours ?? this.totalHours,
      status: status ?? this.status,
      message: message ?? this.message,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }
}
