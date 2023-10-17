part of 'product_cubit.dart';

@immutable
abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

// ignore: must_be_immutable
class ProductLoaded extends ProductState {
  ProductsModel? items;
  ProductLoaded(this.items);

}

// ignore: must_be_immutable
class ProductError extends ProductState {
  String ErrorMessage;
  ProductError(this.ErrorMessage);
  
}
