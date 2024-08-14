import 'package:new_project/Networks/ApiServices.dart';
import 'package:new_project/Networks/models/product_model.dart';

class FavouriteService {
  
  Future<Iterable<ProductModel>> getAll() async {
    final res =
        await ApiServices.instance.get(url: '/products?limit=5', variables: {});
    Iterable<ProductModel> products =
        (res.msg?.data as List).map((e) => ProductModel.fromMap(e));
    return products;
  }

  Future<bool> add(Map<String, dynamic> item) async {
    
    // Convert the item to a JSON string
    // String itemJson = json.encode(item);

    // Store the JSON string in local storage using a unique key for the item
    // return await LocalStorageService.instance.setDynamic(
    //   key: item['id'].toString(), // Assuming the product has an 'id' field
    //   value: itemJson,
    // );

    return true;
  }

  Future<bool> remove(String id) async {
    // Remove the item from local storage by its id
    // return await LocalStorageService.instance.delete(id);
    return true;
  }


}
