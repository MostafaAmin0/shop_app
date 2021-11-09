import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_app/model/http_exception.dart';
import '../providers/orders_provider.dart' show OrdersProvider;
import '../widget/order_item.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({Key? key}) : super(key: key);

  static const route = '/order-screen';

  @override
  Widget build(BuildContext context) {
    /// this line cause infinite loop 
    // final ordersProvider = Provider.of<OrdersProvider>(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders'),
      ),
      body: FutureBuilder(
        future:
            Provider.of<OrdersProvider>(context, listen: false).fetchOrders(),
        builder: (ctx, snapShotData) {
          if (snapShotData.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapShotData.error != null) {
            ///handle error
            throw HttpException('error');
          } else {
            return Consumer<OrdersProvider>(builder: (ctx, orderData, child) {
              return ListView.builder(
                itemCount: orderData.orderCount,
                itemBuilder: (context, index) {
                  var order = orderData.orders[index];
                  return OrderItem(order);
                },
              );
            });
          }
        },
      ),
    );
  }
}
