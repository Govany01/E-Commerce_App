import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:final_project/model/ProductModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../Data_Source/product_data_source.dart';

class ProductService {
  String endpoint = "https://dummyjson.com/products";
  final dio = Dio();
  Future<ProductsModel?> getProducts() async {
    ProductsModel? products;
    try {
      final response = await dio.get(endpoint);
      var data = response.data;
      ProductDataSource().cacheProductData(data);

      print(data);
      products = ProductsModel.fromJson(data);
      print("data After ** ${products.products[0]}");
      // products.add(product);
    } catch (e) {
      print(e.toString());
    }

    return products;
  }
}
