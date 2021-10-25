import 'package:flutter/material.dart';

import './product.dart';

class ProductsProvider with ChangeNotifier {
  final List<Product> _items = [
    Product(
      id: 'p1',
      title: 'Red Shirt',
      description: 'A red shirt - it is pretty red!',
      price: 29.99,
      imageUrl:
          'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
    ),
    Product(
      id: 'p2',
      title: 'Trousers',
      description: 'A nice pair of trousers.',
      price: 59.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
    ),
    Product(
      id: 'p3',
      title: 'Yellow Scarf',
      description: 'Warm and cozy - exactly what you need for the winter.',
      price: 19.99,
      imageUrl:
          'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
    ),
    Product(
      id: 'p4',
      title: 'A Pan',
      description: 'Prepare any meal you want.',
      price: 49.99,
      imageUrl:
          'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
    ),
  ];

  bool _isFavorite = false;

  ///important to not just return _items "List" as it's pass by refrenece
  List<Product> get products {
    _isFavorite = false;
    return [..._items];
  }

  List<Product> get favoriteProducts {
    _isFavorite = true;
    return _items.where((product) => product.isFav).toList();
  }

  void addProduct({
    required String title,
    required String description,
    required double price,
    required String imageUrl,
  }) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: title,
      description: description,
      price: price,
      imageUrl: imageUrl,
    );
    _items.insert(0, newProduct);
    notifyListeners();
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  void updateProduct({
    required String id,
    required String title,
    required String description,
    required double price,
    required String imageUrl,
  }) {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex != -1) {
      _items[prodIndex] = Product(
        id: id,
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl,
        isFavorite: _items[prodIndex].isFav,
      );
      notifyListeners();
    }
  }

  void refreshFavoriteList() {
    if (_isFavorite) {
      notifyListeners();
    }
  }
}
