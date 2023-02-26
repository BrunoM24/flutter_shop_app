import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/providers/cart.dart';
import 'package:shop_app/providers/products.dart';
import 'package:shop_app/screens/cart_details.dart';
import 'package:shop_app/widgets/my_drawer.dart';
import 'package:shop_app/widgets/product_item.dart';

enum FilterOptions { favorites, all }

class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  bool _filterFavorites = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('MyShop'),
        actions: [
          Consumer<Cart>(
            builder: (context, cart, child) => IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const CartDetailsScreen(),
                ),
              ),
              icon: Badge.count(
                count: cart.itemCount,
                child: child,
              ),
            ),
            child: const Icon(Icons.shopping_cart),
          ),
          PopupMenuButton(
            onSelected: (FilterOptions value) => setState(
              () => _filterFavorites = value == FilterOptions.favorites,
            ),
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(
                value: FilterOptions.favorites,
                child: Text('Favorites'),
              ),
              const PopupMenuItem(
                value: FilterOptions.all,
                child: Text('All'),
              ),
            ],
          ),
        ],
      ),
      drawer: const MyDrawer(),
      body: _ProductsGrid(_filterFavorites),
    );
  }
}

class _ProductsGrid extends StatelessWidget {
  final bool filterFavorites;

  const _ProductsGrid(this.filterFavorites);

  @override
  Widget build(BuildContext context) {
    final products = filterFavorites
        ? Provider.of<Products>(context).favorites
        : Provider.of<Products>(context).products;

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 5 / 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) => ChangeNotifierProvider.value(
        value: products.elementAt(index),
        child: const ProductItem(),
      ),
      itemCount: products.length,
    );
  }
}
