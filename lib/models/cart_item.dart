import 'package:shop_app/models/product.dart';

class CartItem {
  final String id;
  final Product product;
  int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
  });

  @override
  String toString() {
    return 'CartItem{id: $id, product: $product, quantity: $quantity}';
  }
}
