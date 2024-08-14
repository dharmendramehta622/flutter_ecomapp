part of 'favourite_bloc.dart';

sealed class FavouriteEvent extends Equatable {
  const FavouriteEvent();

  @override
  List<Object> get props => [];
}

class AddToFavourite extends FavouriteEvent {
  const AddToFavourite({required this.item});

  final Map<String, dynamic> item;
}

class RemoveFromFavourite extends FavouriteEvent {
  const RemoveFromFavourite({required this.item});

  final Map<String, dynamic> item;
}

class LoadFavourite extends FavouriteEvent {
 
}
