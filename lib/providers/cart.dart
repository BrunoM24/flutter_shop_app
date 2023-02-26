import 'package:flutter/material.dart';
import 'package:shop_app/models/cart_item.dart';
import 'package:shop_app/models/product.dart';

class Cart with ChangeNotifier {
  final Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  int get itemCount {
    return _items.length;
  }

  double get totalAmount {
    double amount = 0;

    _items.forEach(
      (_, value) => amount += (value.quantity * value.product.price),
    );

    return amount;
  }

  void addItem(Product product) {
    _items.putIfAbsent(
      product.id,
      () => CartItem(
        id: DateTime.now().toString(),
        product: product,
        quantity: 0,
      ),
    );

    _items.update(
      product.id,
      (value) => CartItem(
        id: value.id,
        product: value.product,
        quantity: ++value.quantity,
      ),
    );

    notifyListeners();
  }

  void removeItem(String id) {
    _items.remove(id);
    notifyListeners();
  }

  void clearCart() {
    _items.clear();
    notifyListeners();
  }
}
