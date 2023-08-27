// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_2023/src/core/utls/app_routes.dart';
import 'package:shop_2023/src/models/product_register_model.dart';

class ProductItemWidget extends StatelessWidget {
  const ProductItemWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final productRegister = Provider.of<ProductRegisterModel>(context);
    //  final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: IconButton(
            onPressed: () {
              productRegister.toggleFavoriteStatus();
            },
            icon: Icon(
              productRegister.isFavorite ? Icons.favorite : Icons.favorite_border,
              //color: Theme.of(context).colorScheme.secondary,
            ),
            color: Theme.of(context).colorScheme.secondary,
          ),
          title: Text(
            productRegister.title,
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
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                AppRoutes.productDetail,
                arguments: productRegister,
              );
            },
            child: Image.network(
              productRegister.imageUrl,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
