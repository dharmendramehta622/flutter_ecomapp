import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:new_project/Networks/models/product_model.dart';
import 'package:new_project/Networks/services/favourite_service.dart';
import 'package:new_project/blocs/product_bloc/product_bloc.dart';
part 'favourite_event.dart';
part 'favourite_state.dart';

class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  final FavouriteService _services = FavouriteService();

  FavouriteBloc() : super(const FavouriteState()) {

    on<AddToFavourite>((event, emit) async {
      final res = await _services.add(event.item);
      if (res) {
        add(LoadFavourite());
      }
    });

    on<RemoveFromFavourite>((event, emit) async {
      final res = await _services.remove(event.item['id']);
      if (res) {
        add(LoadFavourite());
      }
    });

    on<LoadFavourite>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onPostFetched(
      LoadFavourite event, Emitter<FavouriteState> emit) async {
    if (state.hasReachedMax) return;
    try {
      if (state.status == ListStatus.initial) {
        final products = await _services.getAll();
        return emit(state.copyWith(
          status: ListStatus.success,
          products: products.toList(),
          hasReachedMax: false,
        ));
      }
      final products = await _services.getAll();
      emit(products.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: ListStatus.success,
              products: List.of(state.products)..addAll(products),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: ListStatus.failure));
    }
  }
}
