part of 'favourite_bloc.dart';

enum ListStatus { initial,loading, success, failure }

final class FavouriteState extends Equatable {
  const FavouriteState({
    this.status = ListStatus.initial,
    this.products = const <ProductModel>[],
    this.hasReachedMax = false,
  });

  final ListStatus status;
  final List<ProductModel> products;
  final bool hasReachedMax;

  FavouriteState copyWith({
    ListStatus? status,
    List<ProductModel>? products,
    bool? hasReachedMax,
  }) {
    return FavouriteState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''FavouriteState { status: $status, hasReachedMax: $hasReachedMax, products: ${products.length} }''';
  }

  @override
  List<Object> get props => [status, products, hasReachedMax];
}