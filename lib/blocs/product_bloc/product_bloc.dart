import 'package:bloc/bloc.dart';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:new_project/Networks/services/product_service.dart';
import 'package:stream_transform/stream_transform.dart';
import '../../Networks/models/product_model.dart';
part 'product_event.dart';
part 'product_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final ProductServices _services = ProductServices();

  ProductBloc() : super(const ProductState()) {
    on<ProductFetched>(
      _onPostFetched,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onPostFetched(
      ProductFetched event, Emitter<ProductState> emit) async {
    emit(state.copyWith(status: PostStatus.loading));
    if (state.hasReachedMax) return;
    try {
      if (state.status == PostStatus.initial) {
        final products = await _services.getAll();
        return emit(state.copyWith(
          status: PostStatus.success,
          products: products.toList(),
          hasReachedMax: false,
        ));
      }
      final products = await _services.getAll(limit: state.products.length + 5);
      emit(products.isEmpty
          ? state.copyWith(hasReachedMax: true)
          : state.copyWith(
              status: PostStatus.success,
              products: List.of(state.products)..addAll(products),
              hasReachedMax: false,
            ));
    } catch (_) {
      emit(state.copyWith(status: PostStatus.failure));
    }
  }
}
