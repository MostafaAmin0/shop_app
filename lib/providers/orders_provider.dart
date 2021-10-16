import 'package:flutter/foundation.dart';
import './cart_provider.dart';

class OrdersProvider with ChangeNotifier {
  final List<OrederItem> _orders = [];

  List<OrederItem> get orders => [..._orders];

  int get orderCount => _orders.length;

  void addOrder(List<CartItem> cartItems, double total) {
    _orders.insert(
      0,
      OrederItem(
        id: DateTime.now().toString(),
        total: total,
        date: DateTime.now(),
        products: cartItems,
      ),
    );
    notifyListeners();
  }
}

class OrederItem {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  OrederItem({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });
}
