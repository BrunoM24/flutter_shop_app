import 'package:flutter/foundation.dart';
import 'package:shop_app/models/cart_item.dart';
import 'package:shop_app/models/order_item.dart';

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  void addOrder(List<CartItem> items, double totalAmount) {
    _orders.add(
      OrderItem(
        DateTime.now().toString(),
        totalAmount,
        items,
        DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
