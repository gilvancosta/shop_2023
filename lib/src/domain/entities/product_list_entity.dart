// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:shop_2023/src/domain/entities/product_entity.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/constants.dart';
import '../../core/exceptions/http_exception.dart';

class ProductListEntity with ChangeNotifier {
  final List<ProductEntity> _items = [];

  List<ProductEntity> get items => [..._items];
  List<ProductEntity> get favoriteItems => _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  Future<void> loadProducts() async {
    _items.clear();

    //  print('Antes de postar 1');

    final response = await http.get(
      Uri.parse('${Constants.productBaseUrl}.json'),
    );

    // print('Depois de postar 1');

    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      _items.add(
        ProductEntity(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: productData['isFavorite'],
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    // print('Antes de postar 1');

    final product = ProductEntity(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    // print('Depois de postar 1');

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(ProductEntity product) async {
    //  print('Antes de postar 2');

    final response = await http.post(Uri.parse('${Constants.productBaseUrl}.json'),
        body: jsonEncode({
          'name': product.name,
          'description': product.description,
          'price': product.price,
          'imageUrl': product.imageUrl,
          'isFavorite': product.isFavorite,
        }));

    // print('Depois de postar 2');

    final id = jsonDecode(response.body)['name'];
    _items.add(ProductEntity(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
      isFavorite: product.isFavorite,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(ProductEntity product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('${Constants.productBaseUrl}/${product.id}.json'),
        body: jsonEncode(
          {
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );

      _items[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(ProductEntity product) async {
    int index = _items.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = _items[index];
      _items.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Constants.productBaseUrl}/${product.id}.json'),
      );

      if (response.statusCode >= 400) {
        _items.insert(index, product);
        notifyListeners();
        throw HttpException(
          msg: 'Não foi possível excluir o produto.',
          statusCode: response.statusCode,
        );
      }
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