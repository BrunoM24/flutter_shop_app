import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shop_app/models/order_item.dart';

class OrderItemWidget extends StatefulWidget {
  const OrderItemWidget(this.order, {super.key});

  final OrderItem order;

  @override
  State<OrderItemWidget> createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '${widget.order.products.length} products - \$${widget.order.amount}',
            ),
            subtitle: Text(
              DateFormat('H:m dd/MM/yy').format(
                widget.order.dateTime,
              ),
            ),
            trailing: IconButton(
              isSelected: _selected,
              onPressed: () => setState(() => _selected = !_selected),
              icon: _selected
                  ? const Icon(Icons.expand_less)
                  : const Icon(Icons.expand_more),
            ),
          ),
          if (_selected)
            Expanded(
              child: ListView.builder(
                itemCount: widget.order.products.length,
                itemBuilder: (context, index) =>
                    Text(widget.order.products[index].product.title),
              ),
            ),
        ],
      ),
    );
  }
}
