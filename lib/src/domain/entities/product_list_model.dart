import 'package:flutter/material.dart';
import 'package:shop_2023/src/core/data/dummy_product.dart';
import 'package:shop_2023/src/domain/entities/product_model.dart';

class ProductListModel with ChangeNotifier {
  final List<ProductModel> _items = dummyProducts;

  List<ProductModel> get items => [..._items]; // retorna uma cópia da lista

  List<ProductModel> get favoriteItems => _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  void addProduct(ProductModel product) {
    _items.add(product);
    notifyListeners();
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