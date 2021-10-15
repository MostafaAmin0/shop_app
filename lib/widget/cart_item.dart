import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key? key,
    required this.price,
    required this.id,
    required this.title,
    required this.quantity,
  }) : super(key: key);

  final double price;
  final String id;
  final String title;
  final int quantity;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ListTile(
          leading: CircleAvatar(
            radius: 30,
            child: Padding(padding: const EdgeInsets.all(4),child: FittedBox(child: Text('\$$price'))),
          ),
          title: Text(title),
          subtitle: Text('Total : \$${price * quantity}'),
          trailing: Text('$quantity x'),
        ),
      ),
    );
  }
}
