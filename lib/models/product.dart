import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imgUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imgUrl,
    this.isFavorite = false,
  });

  void toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();

    final url = Uri.https(
      'flutter-shop-app-780d7-default-rtdb.europe-west1.firebasedatabase.app',
      'products/$id.json',
    );

    patch(
      url,
      body: jsonEncode(
        {
          'isFavorite': isFavorite,
        },
      ),
    ).then((value) {
      if (value.statusCode >= 400) {
        isFavorite = !isFavorite;
        notifyListeners();
      }
    });
  }

  Product copyWith({
    String? id,
    String? title,
    String? description,
    double? price,
    String? imgUrl,
    bool? isFavorite,
  }) {
    return Product(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      price: price ?? this.price,
      imgUrl: imgUrl ?? this.imgUrl,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  String toString() {
    return 'Product{id: $id, title: $title, description: $description, price: $price, imgUrl: $imgUrl, isFavorite: $isFavorite}';
  }
}
