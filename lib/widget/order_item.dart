import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../providers/orders_provider.dart' as ord;

class OrderItem extends StatelessWidget {
  const OrderItem(this.order, {Key? key}) : super(key: key);

  final ord.OrederItem order;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          ListTile(
            title: Text('\$${order.total}'),
            subtitle: Text(
              DateFormat('dd MM yyyy hh:mm').format(order.date),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.expand_more),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}
