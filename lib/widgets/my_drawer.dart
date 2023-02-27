import 'package:flutter/material.dart';
import 'package:shop_app/screens/orders_screen.dart';
import 'package:shop_app/screens/products_overview.dart';
import 'package:shop_app/screens/user_products_screen.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Menu'),
            automaticallyImplyLeading: false,
          ),
          ListTile(
            leading: const Icon(Icons.storefront),
            title: const Text('Shop'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProductsOverviewScreen(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.receipt_long_outlined),
            title: const Text('Orders'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const OrdersScreen(),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.sell_outlined),
            title: const Text('My Products'),
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const UserProductsScreen(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
