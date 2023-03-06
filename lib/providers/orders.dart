import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import 'package:shop_app/models/cart_item.dart';
import 'package:shop_app/models/order_item.dart';

class Orders with ChangeNotifier {
  final List<OrderItem> _orders = [];

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> addOrder(List<CartItem> items, double totalAmount) async {
    final url = Uri.https(
      'flutter-shop-app-780d7-default-rtdb.europe-west1.firebasedatabase.app',
      'orders.json',
    );

    final DateTime creationDate = DateTime.now();

    var response = await post(
      url,
      body: jsonEncode(
        {
          'amount': totalAmount,
          'dateTime': creationDate.toIso8601String(),
          'products': items
              .map(
                (item) => {
                  'id': item.id,
                  'product': {
                    'id': item.product.id,
                    'title': item.product.title,
                    'price': item.product.price,
                  },
                  'quantity': item.quantity
                },
              )
              .toList(),
        },
      ),
    );

    _orders.add(
      OrderItem(
        jsonDecode(response.body)['name'],
        totalAmount,
        items,
        DateTime.now(),
      ),
    );

    notifyListeners();
  }
}
