import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shop_app/model/http_exception.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavorite = false,
  });

  bool get isFav => isFavorite;

  Future<void> toggleFavoriteStatus(
      String id, String authToken, String userId) async {
    isFavorite = !isFavorite;
    notifyListeners();
    final url = Uri.parse(
      'https://shop-app-ef819-default-rtdb.europe-west1.firebasedatabase.app/userFavorite/$userId/$id.json?auth=$authToken',
    );
    final response = await http.put(
      url,
      body: json.encode(isFavorite),
    );
    if (response.statusCode >= 400) {
      isFavorite = !isFavorite;
      notifyListeners();

      ///throw exception here to show SnackBar /Show Dialog anywhere
      throw HttpException('Failed to connect...');
    }
  }
}
