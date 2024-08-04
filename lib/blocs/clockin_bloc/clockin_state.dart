part of 'clockin_bloc.dart';

sealed class ClockinState extends Equatable {
  const ClockinState();
  
  @override
  List<Object> get props => [];
}

final class ClockinInitial extends ClockinState {}
