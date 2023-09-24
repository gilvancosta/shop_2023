// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_2023/src/domain/entities/product_list_entity.dart';
import 'package:shop_2023/src/domain/entities/product_entity.dart';
import 'package:shop_2023/src/ui/pages/home/widgets/product_gridtile_widget.dart';

class ProductsGridViewWidget extends StatelessWidget {
  final bool showFavoriteOnly;

  const ProductsGridViewWidget({
    Key? key,
    required this.showFavoriteOnly,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductListEntity>(context);

      final List<ProductEntity> loadedProducts = showFavoriteOnly ? provider.favoriteItems : provider.items;


  

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
        // create: (c) => loadedProducts[i],
        value: loadedProducts[i],

        child: const ProductGridTileWidget(),
      ),
      // itemBuilder: (context, index) => Text(loadedProducts[index].title),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      ),
    );
  }
}
