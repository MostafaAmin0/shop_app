import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import './cart_provider.dart';

class OrdersProvider with ChangeNotifier {
  final List<OrederItem> _orders = [];

  List<OrederItem> get orders => [..._orders];

  int get orderCount => _orders.length;

  Future<void> addOrder(List<CartItem> cartItems, double total) async{
    final url = Uri.https(
      'shop-app-ef819-default-rtdb.europe-west1.firebasedatabase.app',
      '/orders.json',
    );
    final date=DateTime.now();
    final response=await http.post(
      url,
      body: json.encode({
        'total': total,
        'date':date.toIso8601String(),
        'products': cartItems.map((cp) =>{
          'id':cp.id,
          'title':cp.title,
          'price':cp.price,
          'quantity':cp.quantity,
        }).toList(),
      }),
    );
    _orders.insert(
      0,
      OrederItem(
        id: json.decode(response.body)['name'],
        total: total,
        date: date,
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
