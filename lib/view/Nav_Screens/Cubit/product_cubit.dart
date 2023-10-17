import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../Data_Source/product_data_source.dart';
import '../../../model/ProductModel.dart';
import '../../../service/ProductService.dart';

part 'product_state.dart';

class ProductCubit extends Cubit<ProductState> {
  ProductCubit() : super(ProductInitial()) {
    getProducts();
  }

  getProducts() async {
    try {
      emit(ProductLoading());
      ProductsModel? Products;
      ProductsModel? tempProduct;
      tempProduct = await ProductDataSource().getFromApi();
      if (tempProduct == null) {
        tempProduct = await ProductDataSource().getFromCached();
      }
      Products = tempProduct;

      emit(ProductLoaded(Products));
    } catch (e) {
      emit(ProductError(e.toString()));
    }
  }
}
