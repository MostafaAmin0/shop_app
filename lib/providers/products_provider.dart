import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../model/http_exception.dart';

import './product.dart';

class ProductsProvider with ChangeNotifier {
  List<Product> _items = [];
  // [
  //   Product(
  //     id: 'p1',
  //     title: 'Red Shirt',
  //     description: 'A red shirt - it is pretty red!',
  //     price: 29.99,
  //     imageUrl:
  //         'https://cdn.pixabay.com/photo/2016/10/02/22/17/red-t-shirt-1710578_1280.jpg',
  //   ),
  //   Product(
  //     id: 'p2',
  //     title: 'Trousers',
  //     description: 'A nice pair of trousers.',
  //     price: 59.99,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e8/Trousers%2C_dress_%28AM_1960.022-8%29.jpg/512px-Trousers%2C_dress_%28AM_1960.022-8%29.jpg',
  //   ),
  //   Product(
  //     id: 'p3',
  //     title: 'Yellow Scarf',
  //     description: 'Warm and cozy - exactly what you need for the winter.',
  //     price: 19.99,
  //     imageUrl:
  //         'https://live.staticflickr.com/4043/4438260868_cc79b3369d_z.jpg',
  //   ),
  //   Product(
  //     id: 'p4',
  //     title: 'A Pan',
  //     description: 'Prepare any meal you want.',
  //     price: 49.99,
  //     imageUrl:
  //         'https://upload.wikimedia.org/wikipedia/commons/thumb/1/14/Cast-Iron-Pan.jpg/1024px-Cast-Iron-Pan.jpg',
  //   ),
  // ];

  bool _isFavorite = false;
  String authToken;

  ProductsProvider(this.authToken);

  ///important to not just return _items "List" as it's pass by refrenece
  List<Product> get products {
    _isFavorite = false;
    return [..._items];
  }

  List<Product> get favoriteProducts {
    _isFavorite = true;
    return _items.where((product) => product.isFav).toList();
  }

  Future<void> addProduct({
    required String title,
    required String description,
    required double price,
    required String imageUrl,
  }) async {
    try {
      ///don't put http at begining of your url or use
      // final url = Uri.https(
      //   'shop-app-ef819-default-rtdb.europe-west1.firebasedatabase.app',
      //   '/products.json?auth=$authToken',
      // );
      final url = Uri.parse(
          'https://shop-app-ef819-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken');
      final response = await http.post(
        url,
        body: json.encode({
          'title': title,
          'description': description,
          'price': price,
          'imageUrl': imageUrl,
          'isFavorite': false,
        }),
      );
      final newProduct = Product(
        id: json.decode(response.body)['name'],
        title: title,
        description: description,
        price: price,
        imageUrl: imageUrl,
      );
      _items.insert(0, newProduct);
      notifyListeners();
    } catch (error) {
      rethrow;
    }
  }

  Future<void> fetchData() async {
    try {
      final url = Uri.parse(
        'https://shop-app-ef819-default-rtdb.europe-west1.firebasedatabase.app/products.json?auth=$authToken',
      );
      final response = await http.get(url);
      if (jsonDecode(response.body) == null) {
        _items = [];
        notifyListeners();
        return;
      }
      final extractedData = json.decode(response.body) as Map<String, dynamic>;
      List<Product> loadedProducts = [];
      extractedData.forEach((prodId, prodData) {
        loadedProducts.insert(
          0,
          Product(
            id: prodId,
            description: prodData['description'],
            imageUrl: prodData['imageUrl'],
            price: prodData['price'],
            title: prodData['title'],
            isFavorite: prodData['isFavorite'],
          ),
        );
        _items = loadedProducts;
        notifyListeners();
      });
    } catch (e) {
      rethrow;
    }
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }

  Future<void> updateProduct({
    required String id,
    required String title,
    required String description,
    required double price,
    required String imageUrl,
  }) async {
    final prodIndex = _items.indexWhere((prod) => prod.id == id);
    if (prodIndex != -1) {
      final url = Uri.parse(
        'https://shop-app-ef819-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$authToken',
      );
      try {
        await http.patch(
          url,
          body: json.encode({
            'title': title,
            'description': description,
            'price': price,
            'imageUrl': imageUrl,
          }),
        );
      } catch (e) {
        rethrow;
      }
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

  Future<void> deleteProduct(String id) async {
    final url = Uri.parse(
      'https://shop-app-ef819-default-rtdb.europe-west1.firebasedatabase.app/products/$id.json?auth=$authToken',
    );
    final index = _items.indexWhere((prod) => prod.id == id);
    final existingProduct = _items[index];
    _items.removeAt(index);
    notifyListeners();
    final response = await http.delete(url);
    if (response.statusCode >= 400) {
      _items.insert(index, existingProduct);
      notifyListeners();
      throw HttpException('Failed to delete..');
    }
  }

  void refreshFavoriteList() {
    if (_isFavorite) {
      notifyListeners();
    }
  }
}
