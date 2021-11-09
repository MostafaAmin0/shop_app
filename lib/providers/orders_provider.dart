import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart_provider.dart';

class OrdersProvider with ChangeNotifier {
  List<OrderItem> _orders = [];

  List<OrderItem> get orders => [..._orders];

  int get orderCount => _orders.length;

  Future<void> addOrder(List<CartItem> cartItems, double total) async {
    final url = Uri.https(
      'shop-app-ef819-default-rtdb.europe-west1.firebasedatabase.app',
      '/orders.json',
    );
    final date = DateTime.now();
    final response = await http.post(
      url,
      body: json.encode({
        'total': total,
        'date': date.toIso8601String(),
        'products': cartItems
            .map((cp) => {
                  'id': cp.id,
                  'title': cp.title,
                  'price': cp.price,
                  'quantity': cp.quantity,
                })
            .toList(),
      }),
    );
    _orders.insert(
      0,
      OrderItem(
        id: json.decode(response.body)['name'],
        total: total,
        date: date,
        products: cartItems,
      ),
    );
    notifyListeners();
  }

  Future<void> fetchOrders() async {
    final url = Uri.https(
      'shop-app-ef819-default-rtdb.europe-west1.firebasedatabase.app',
      '/orders.json',
    );
    final response = await http.get(url);
    List<OrderItem> loadedOrders = [];
    final extractedData = json.decode(response.body) as Map<String, dynamic>;
    extractedData.forEach((orderId, orderData) {
      List<CartItem> products = [];
      final extractedProducts = orderData['products'] as List<dynamic>;
      for (var prodData in extractedProducts) {
        products.insert(
          0,
          CartItem(
            id: prodData['id'],
            price: prodData['price'],
            quantity: prodData['quantity'],
            title: prodData['title'],
          ),
        );
        loadedOrders.insert(
          0,
          OrderItem(
            id: orderId,
            date: DateTime.parse(orderData['date']),
            products: products,
            total: orderData['total'],
          ),
        );
      }
    });
    _orders = loadedOrders;
    notifyListeners();
  }
}

class OrderItem {
  final String id;
  final double total;
  final List<CartItem> products;
  final DateTime date;

  OrderItem({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });
}
