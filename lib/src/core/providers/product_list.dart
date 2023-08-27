import 'package:flutter/material.dart';
import 'package:shop_2023/src/core/data/dummy_product.dart';
import 'package:shop_2023/src/models/product_register_model.dart';

class ProductList with ChangeNotifier {
  final List<ProductRegisterModel> _items = dummyProducts;

  List<ProductRegisterModel> get items => [..._items];

  void addProduct(ProductRegisterModel product) {
    _items.add(product);
    notifyListeners();
  }
}
