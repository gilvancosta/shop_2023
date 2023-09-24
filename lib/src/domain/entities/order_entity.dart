import 'package:shop_2023/src/domain/entities/cart_item_entity.dart';

class OrderEntity {
  final String id;
  final double total;
  final List<CartItemEntity> products;
  final DateTime date;

  OrderEntity({
    required this.id,
    required this.total,
    required this.products,
    required this.date,
  });
}
