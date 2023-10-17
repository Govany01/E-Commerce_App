import 'package:flutter/cupertino.dart';
import 'itemsModel.dart';

class CartProduct with ChangeNotifier {
  List<CartItem> _items = [];

  List<CartItem> get items => _items;

  void addToCart(CartItem item) {
    _items.add(item);
    notifyListeners();
    print(_items);
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
    void removeFromCart(CartItem item) {
    _items.remove(item);
    notifyListeners();
  }
  
}
