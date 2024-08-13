part of 'product_bloc.dart';


enum PostStatus { initial,loading, success, failure }

final class ProductState extends Equatable {
  const ProductState({
    this.status = PostStatus.initial,
    this.products = const <ProductModel>[],
    this.hasReachedMax = false,
  });

  final PostStatus status;
  final List<ProductModel> products;
  final bool hasReachedMax;

  ProductState copyWith({
    PostStatus? status,
    List<ProductModel>? products,
    bool? hasReachedMax,
  }) {
    return ProductState(
      status: status ?? this.status,
      products: products ?? this.products,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''ProductState { status: $status, hasReachedMax: $hasReachedMax, products: ${products.length} }''';
  }

  @override
  List<Object> get props => [status, products, hasReachedMax];
}