// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_2023/src/core/providers/product_list.dart';
import 'package:shop_2023/src/models/product_register_model.dart';
import 'package:shop_2023/src/pages/home/widgets/product_item_widget.dart';

class GridviewProductsWidget extends StatelessWidget {
  const GridviewProductsWidget({super.key});




  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductList>(context);
    final List<ProductRegisterModel> loadedProducts = provider.items;

    return GridView.builder(
      padding: const EdgeInsets.all(10),
      itemCount: loadedProducts.length,
      itemBuilder: (ctx, i) => ChangeNotifierProvider(
        create: (c) => loadedProducts[i],
        child: const ProductItemWidget(),
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
