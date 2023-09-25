// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:shop_2023/src/core/data/dummy_product.dart';
import 'package:shop_2023/src/domain/entities/product_entity.dart';
import 'package:http/http.dart' as http;

class ProductListEntity with ChangeNotifier {
  final List<ProductEntity> _items = dummyProducts;
  final _baseUrl = 'https://shop-2023-3b069-default-rtdb.firebaseio.com';

  List<ProductEntity> get items => [..._items];
  List<ProductEntity> get favoriteItems => _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  void saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    print('Antes de postar 1');

    final product = ProductEntity(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    print('Depois de postar 1');

    if (hasId) {
      updateProduct(product);
    } else {
      addProduct(product);
    }
  }

  void addProduct(ProductEntity product) {
    print('Antes de postar 2');

    http.post(Uri.parse('$_baseUrl/product.json'),
        body: jsonEncode({
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        }));

    print('Depois de postar 2');

    _items.add(product);
    notifyListeners();
  }

  void updateProduct(ProductEntity product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void removeProduct(ProductEntity product) {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      _items.removeWhere((p) => p.id == product.id);
      notifyListeners();
    }
  }
}
/*  
  bool _showFavoriteOnly = false;



 List<ProductRegisterModel> get favoriteItems {

    if (_showFavoriteOnly) {
      return _items.where((prod) => prod.isFavorite).toList();
    }
    return [..._items];

  }


  void showFavoriteOnly() {
    _showFavoriteOnly = true;
    notifyListeners();
  }

  void showFavoriteAll() {
    _showFavoriteOnly = false;
    notifyListeners();
  }
 */