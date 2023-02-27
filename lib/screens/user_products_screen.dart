import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/product.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/edit_product_screen.dart';
import 'package:shop_app/widgets/my_drawer.dart';
import 'package:shop_app/widgets/user_product_item.dart';

class UserProductsScreen extends StatelessWidget {
  const UserProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Product> products = Provider.of<Products>(context).products;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Products'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const EditProductScreen(),
              ),
            ),
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) => Column(
          children: [
            UserProductItem(products[index]),
            const Divider(
              indent: 12,
              endIndent: 12,
            ),
          ],
        ),
      ),
    );
  }
}
