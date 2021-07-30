import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shop/exceptions/http_exception.dart';
import 'package:shop/utils/constants.dart';

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavorite;

  Product({
    this.id,
    @required this.title,
    @required this.description,
    @required this.price,
    @required this.imageUrl,
    this.isFavorite = false
  });

  void _toggleFavorite() {
    isFavorite = !isFavorite;
    notifyListeners();
  }

  Future<void> toggleFavorite(String token) async {
    String _baseUrl = '${Constants.BASE_API_URL}/products/$id.json?auth=$token';

    _toggleFavorite();

    try {
      final response = await http.patch(
        Uri.parse(_baseUrl),
        body: json.encode({
          'isFavorite': isFavorite
        })
      );

      if (response.statusCode >= 400) {
        _toggleFavorite();
        throw HttpException('Ocorreu um erro ao adicionar favorito');
      }
    } catch (error) {
      _toggleFavorite();
      throw HttpException('Ocorreu um erro ao adicionar favorito');
    }
  }
}