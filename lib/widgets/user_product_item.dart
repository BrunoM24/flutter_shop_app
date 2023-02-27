import 'package:flutter/material.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/screens/edit_product_screen.dart';

class UserProductItem extends StatelessWidget {
  final Product product;

  const UserProductItem(this.product, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imgUrl),
      ),
      title: Text(product.title),
      subtitle: Text(product.description),
      trailing: IconButton(
        icon: const Icon(Icons.edit),
        iconSize: 20,
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const EditProductScreen(),
          ),
        ),
      ),
    );
  }
}
