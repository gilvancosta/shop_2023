// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';

import 'package:shop_2023/src/domain/entities/product_entity.dart';
import 'package:http/http.dart' as http;

import '../../core/constants/constants.dart';
import '../../core/exceptions/http_exception.dart';

class ProductListEntity with ChangeNotifier {
  final String _token;
  final String _userId;
  List<ProductEntity> pItems = [];

  List<ProductEntity> get items => [...pItems];
  List<ProductEntity> get favoriteItems => pItems.where((prod) => prod.isFavorite).toList();

  ProductListEntity([
    this._token = '',
    this._userId = '',
    this.pItems = const [],
  ]);

  int get itemsCount {
    return pItems.length;
  }

  Future<void> loadProducts() async {
    pItems.clear();

    final response = await http.get(
      Uri.parse('${Constants.productBaseUrl}.json?auth=$_token'),
    );
    if (response.body == 'null') return;

    final favResponse = await http.get(
      Uri.parse(
        '${Constants.userFavoritesUrl}/$_userId.json?auth=$_token',
      ),
    );

    Map<String, dynamic> favData = favResponse.body == 'null' ? {} : jsonDecode(favResponse.body);

    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((productId, productData) {
      final isFavorite = favData[productId] ?? false;
      pItems.add(
        ProductEntity(
          id: productId,
          name: productData['name'],
          description: productData['description'],
          price: productData['price'],
          imageUrl: productData['imageUrl'],
          isFavorite: isFavorite,
        ),
      );
    });
    notifyListeners();
  }

  Future<void> saveProduct(Map<String, Object> data) {
    bool hasId = data['id'] != null;

    final product = ProductEntity(
      id: hasId ? data['id'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price: data['price'] as double,
      imageUrl: data['imageUrl'] as String,
    );

    // print('product ID: ${product.id}');

    if (hasId) {
      return updateProduct(product);
    } else {
      return addProduct(product);
    }
  }

  Future<void> addProduct(ProductEntity product) async {
    final response = await http.post(
      Uri.parse('${Constants.productBaseUrl}.json?auth=$_token'),
      body: jsonEncode(
        {
          "name": product.name,
          "description": product.description,
          "price": product.price,
          "imageUrl": product.imageUrl,
        },
      ),
    );

    print('product ID: ${product.id}');

    final id = jsonDecode(response.body)['name'];

    // print('DEPOIS ID: $id');

    pItems.add(ProductEntity(
      id: id,
      name: product.name,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    ));
    notifyListeners();
  }

  Future<void> updateProduct(ProductEntity product) async {
    int index = pItems.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      await http.patch(
        Uri.parse('${Constants.productBaseUrl}/${product.id}.json?auth=$_token'),
        body: jsonEncode(
          {
            "name": product.name,
            "description": product.description,
            "price": product.price,
            "imageUrl": product.imageUrl,
          },
        ),
      );

      pItems[index] = product;
      notifyListeners();
    }
  }

  Future<void> removeProduct(ProductEntity product) async {
    int index = pItems.indexWhere((p) => p.id == product.id);

    if (index >= 0) {
      final product = pItems[index];
      pItems.remove(product);
      notifyListeners();

      final response = await http.delete(
        Uri.parse('${Constants.productBaseUrl}/${product.id}.json?auth=$_token'),
      );

      if (response.statusCode >= 400) {
        pItems.insert(index, product);
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