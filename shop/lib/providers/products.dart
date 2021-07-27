import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop/data/dummy_data.dart';
import 'product.dart';

class Products with ChangeNotifier {

  List<Product> _items = DUMMY_PRODUCTS;

  // bool _showFavoriteOnly = false;

  List<Product> get items => [ ..._items ];
  List<Product> get favoriteItems {
    return _items.where((prod) => prod.isFavorite).toList();
  }
  
  int get itemCount {
    return _items.length;
  }

  // void showFavoriteOnly() {
  //   _showFavoriteOnly = true;
  //   notifyListeners();
  // }
  // void showAll() {
  //   _showFavoriteOnly = false;
  //   notifyListeners();
  // }

  void addProduct(Product newProduct) {
    Uri url = Uri.parse('https://flutter-cod3r-fcee3-default-rtdb.firebaseio.com/products.json');
    http.post(
      url,
      body: json.encode({
        'title': newProduct.title,
        'description': newProduct.description,
        'price': newProduct.price,
        'imageUrl': newProduct.imageUrl,
        'isFavorite': newProduct.isFavorite
      })
    ).then((response) {
      print(json.decode(response.body));
      _items.add(Product(
        id: json.decode(response.body)['name'],
        title: newProduct.title,
        description: newProduct.description,
        price: newProduct.price,
        imageUrl: newProduct.imageUrl
      ));
      notifyListeners();
    });
  }

  void updateProduct(Product product) {
    if (product == null || product.id == null) {
      return;
    }

    final int index = _items.indexWhere((prod) => prod.id == product.id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    final int index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _items.removeWhere((prod) => prod.id == id);
      notifyListeners();
    }
  }
}