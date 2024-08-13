import 'package:new_project/Networks/ApiServices.dart';
import '../models/product_model.dart';

class ProductServices {
  Future<Iterable<ProductModel>> getAll({int limit=5} ) async {
    final res = await ApiServices.instance.get(url: '/products?limit=$limit', variables: {});
    Iterable<ProductModel> products =
        res.msg?.data.map((e) => ProductModel.fromMap(e));
    return products;
  }

  Future<ProductModel> get(int id) async {
    final res =
        await ApiServices.instance.get(url: '/products/$id', variables: {});
    final product = ProductModel.fromMap(res.msg?.data);
    return product;
  }
}
