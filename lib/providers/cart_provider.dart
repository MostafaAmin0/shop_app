import 'package:flutter/foundation.dart';

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items => {..._items};

  int get itemCount => _items.length;

  void addItem(String productId, String title, double price) {
    if (_items.containsKey(productId)) {
      _items.update(
        productId,
        (item) => CartItem(
          id: item.id,
          price: item.price,
          title: item.title,
          quantity: item.quantity + 1,
        ),
      );
    } else {
      _items.putIfAbsent(
        productId,
        () => CartItem(
          id: DateTime.now().toString(),
          price: price,
          title: title,
          quantity: 1,
        ),
      );
    }
    notifyListeners();
  }

  double get totalPrice {
    double total = 0;
    _items.forEach((key, item) => total += (item.price * item.quantity));
    return total;
  }

  void removeItem(String productId){
    _items.remove(productId);
    notifyListeners();
  }

  void clearCart(){
    _items={};
    notifyListeners();
  }

}

class CartItem {
  final String id;
  final String title;
  final int quantity;
  final double price;

  CartItem({
    required this.id,
    required this.title,
    required this.quantity,
    required this.price,
  });
}
