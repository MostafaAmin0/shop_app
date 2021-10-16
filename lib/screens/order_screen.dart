import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/orders_provider.dart' show OrdersProvider;
import '../widget/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  static const route ='/order-screen';

  @override
  Widget build(BuildContext context) {
    final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: ListView.builder(
        itemCount: ordersProvider.orderCount,
        itemBuilder: (context, index) {
          var order = ordersProvider.orders[index];
          return OrderItem(order);
        },
      ),
    );
  }
}
