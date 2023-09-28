import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shop_2023/src/domain/entities/order_entity.dart';

import '../../core/constants/constants.dart';
import 'cart_entity.dart';
import 'cart_item_entity.dart';

class OrderListEntity with ChangeNotifier {
  final String _token;
  final String _userId;
  List<OrderEntity> pItems = [];

  OrderListEntity([
    this._token = '',
    this._userId = '',
    this.pItems = const [],
  ]);

  List<OrderEntity> get items {
    return [...pItems];
  }

  int get itemsCount {
    return pItems.length;
  }

  Future<void> loadOrders() async {
    List<OrderEntity> items = [];

    final response = await http.get(
      Uri.parse('${Constants.orderBaseUrl}/$_userId.json?auth=$_token'),
    );
    if (response.body == 'null') return;
    Map<String, dynamic> data = jsonDecode(response.body);
    data.forEach((orderId, orderData) {
      items.add(
        OrderEntity(
          id: orderId,
          date: DateTime.parse(orderData['date']),
          total: orderData['total'],
          products: (orderData['products'] as List<dynamic>).map((item) {
            return CartItemEntity(
              id: item['id'],
              productId: item['productId'],
              name: item['name'],
              quantity: item['quantity'],
              price: item['price'],
            );
          }).toList(),
        ),
      );
    });

    pItems = items.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrder(CartEntity cart) async {
    final date = DateTime.now();

    final response = await http.post(
      Uri.parse('${Constants.orderBaseUrl}/$_userId.json?auth=$_token'),
      body: jsonEncode(
        {
          'total': cart.totalAmount,
          'date': date.toIso8601String(),
          'products': cart.items.values
              .map(
                (cartItem) => {
                  'id': cartItem.id,
                  'productId': cartItem.productId,
                  'name': cartItem.name,
                  'quantity': cartItem.quantity,
                  'price': cartItem.price,
                },
              )
              .toList(),
        },
      ),
    );

    final id = jsonDecode(response.body)['name'];
    pItems.insert(
      0,
      OrderEntity(
        id: id,
        total: cart.totalAmount,
        date: date,
        products: cart.items.values.toList(),
      ),
    );

    notifyListeners();
  }
}
