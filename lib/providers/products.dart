import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:shop_app/models/product.dart';

class Products with ChangeNotifier {
  List<Product> _products = [];

  late final String authToken;

  List<Product> get products {
    return [..._products];
  }

  List<Product> get favorites {
    return [...products].where((element) => element.isFavorite).toList();
  }

  Future<void> getProducts() async {
    final url = Uri.https(
      'flutter-shop-app-780d7-default-rtdb.europe-west1.firebasedatabase.app',
      'products.json',
      {
        'auth': authToken,
      },
    );

    final List<Product> tmpList = [];

    final data = jsonDecode((await get(url)).body) as Map;

    data.forEach(
      (key, value) => tmpList.add(
        Product(
          id: key,
          title: value['title'],
          description: value['description'],
          price: value['price'],
          imgUrl: value['imgUrl'],
          isFavorite: value['isFavorite'],
        ),
      ),
    );

    _products = tmpList;
    notifyListeners();
  }

  Future<void> addProduct(Product product) async {
    final url = Uri.https(
      'flutter-shop-app-780d7-default-rtdb.europe-west1.firebasedatabase.app',
      'products.json',
    );

    var response = await post(
      url,
      body: jsonEncode(
        {
          'title': product.title,
          'description': product.description,
          'price': product.price,
          'imgUrl': product.imgUrl,
          'isFavorite': product.isFavorite,
        },
      ),
    );

    _products.add(product.copyWith(id: jsonDecode(response.body)['name']));

    notifyListeners();
  }
}
