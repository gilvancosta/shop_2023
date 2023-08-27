import 'package:flutter/material.dart';
import 'package:shop_2023/src/core/data/dummy_product.dart';
import 'package:shop_2023/src/models/product_register_model.dart';

class ProductList with ChangeNotifier {
  final List<ProductRegisterModel> _items = dummyProducts;

  List<ProductRegisterModel> get items => [..._items];
  List<ProductRegisterModel> get favoriteItems => _items.where((prod) => prod.isFavorite).toList();



 /*  bool _showFavoriteOnly = false;

  List<ProductRegisterModel> get items {

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


  void addProduct(ProductRegisterModel product) {
    _items.add(product);
    notifyListeners();
  }
}
