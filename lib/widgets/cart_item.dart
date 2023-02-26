import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/models/cart_item.dart';
import 'package:shop_app/providers/cart.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem cartItem;

  const CartItemWidget(this.cartItem, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Remove Item?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Yes'),
              ),
              MaterialButton(
                color: Theme.of(context).primaryColor,
                onPressed: () => Navigator.pop(context, false),
                child: const Text(
                  'NO',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      },
      background: Container(
        color: Colors.red,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        padding: const EdgeInsets.only(right: 20),
        alignment: AlignmentDirectional.centerEnd,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) => Provider.of<Cart>(context, listen: false)
          .removeItem(cartItem.product.id),
      key: Key(cartItem.product.id),
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        elevation: 2,
        child: ListTile(
          leading: CircleAvatar(
            backgroundImage: NetworkImage(cartItem.product.imgUrl),
          ),
          title: Text(cartItem.product.title),
          subtitle: Text('Quantity: ${cartItem.quantity}'),
          trailing: Chip(
            backgroundColor: Theme.of(context).primaryColor,
            label: Text(
              cartItem.product.price.toString(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
