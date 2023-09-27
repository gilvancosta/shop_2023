// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_2023/src/ui/app_routes.dart';
import 'package:shop_2023/src/domain/entities/product_entity.dart';

import '../../../../domain/entities/cart_entity.dart';


class ProductGridTileWidget extends StatelessWidget {
  const ProductGridTileWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final product = Provider.of<ProductEntity>(context, listen: false);
    final cart = Provider.of<CartEntity>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          leading: Consumer<ProductEntity>(
            builder: (ctx, productRegister2, _) => IconButton(
              onPressed: () {
                productRegister2.toggleFavorite();
              },
              icon: Icon(
                productRegister2.isFavorite ? Icons.favorite : Icons.favorite_border,
                //color: Theme.of(context).colorScheme.secondary,
              ),
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
          title: Text(
            product.name,
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            onPressed: () {
              // Scaffold.of(context).openDrawer();
              cart.addItem(product);
              ScaffoldMessenger.of(context).hideCurrentMaterialBanner();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Added item to cart!'),
                  duration: const Duration(seconds: 2),
                  action: SnackBarAction(
                      label: 'DESFAZER',
                      onPressed: () {
                        cart.removeSingleItem(product.id);
                      }),
                ),
              );

              //  ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
            icon: Icon(
              Icons.shopping_cart,
              color: Theme.of(context).colorScheme.secondary,
            ),
          ),
        ),
        child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.productDetail, arguments: product);
              // Navigator.of(context).pushNamed(AppRoutes.counter);
            },
            child: Image.network(
              product.imageUrl,
              fit: BoxFit.cover,
            )),
      ),
    );
  }
}
