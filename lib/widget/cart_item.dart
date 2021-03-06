import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/cart_provider.dart';

class CartItem extends StatelessWidget {
  const CartItem(
      {Key? key,
      required this.price,
      required this.id,
      required this.title,
      required this.quantity,
      required this.productId})
      : super(key: key);

  final double price;
  final String id;
  final String title;
  final int quantity;
  final String productId;

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: ValueKey(id),
      background: Container(
        color: Theme.of(context).errorColor,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
          size: 40,
        ),
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      ),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        Provider.of<CartProvider>(context, listen: false).removeItem(productId);
      },
      confirmDismiss: (direction) {
        return showDialog(
          context: context,
          builder: (ctx) => AlertDialog(
            title: const Text('Sure ?'),
            content: Text('Do you want to remove $title from order'),
            actions: [
              TextButton(
                child: const Text('Yes'),
                onPressed: () => Navigator.of(ctx).pop(true),
              ),
              TextButton(
                child: const Text('No'),
                onPressed: () =>Navigator.of(ctx).pop(false),
              ),
            ],
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListTile(
            leading: CircleAvatar(
              radius: 30,
              child: Padding(
                  padding: const EdgeInsets.all(4),
                  child: FittedBox(child: Text('\$$price'))),
            ),
            title: Text(title),
            subtitle: Text('Total : \$${price * quantity}'),
            trailing: Text('$quantity x'),
          ),
        ),
      ),
    );
  }
}
