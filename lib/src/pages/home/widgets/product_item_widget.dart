// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shop_2023/src/models/product_register_model.dart';

class ProductItemWidget extends StatelessWidget {
  // final List<ProductRegister> productRegistrer;

  final ProductRegisterModel productRegistrer;

  const ProductItemWidget({
    Key? key,
    required this.productRegistrer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.favorite,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            productRegistrer.title,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              print('Cart');
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        child: Image.network(productRegistrer.imageUrl, fit: BoxFit.cover),
      ),
    );
  }
}
