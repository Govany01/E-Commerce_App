import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../model/ProductModel.dart';
import '../service/ProductService.dart';

class ProductDataSource {
  String SharedKey = "CachedData";
  Future<ProductsModel?> getFromApi() async {
    ProductsModel? items;
    items = await ProductService().getProducts();
    return items;
  }

  Future<ProductsModel?> getFromCached() async {
    ProductsModel? items;
    final prefs = await SharedPreferences.getInstance();
    try {
      var data = prefs.getString(SharedKey);
      var JSONdata = jsonDecode(data ?? "");
      items = ProductsModel.fromJson(JSONdata);
    } catch (e) {
      print("error in Cached");
    }

    return items;
  }

  Future<bool> cacheProductData(var data) async {
    var cached = jsonEncode(data);
    final prefs = await SharedPreferences.getInstance();
    return prefs.setString(SharedKey, cached);
  }
}
