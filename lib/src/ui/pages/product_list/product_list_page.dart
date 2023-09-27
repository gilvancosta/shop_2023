import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../app_routes.dart';
import '../../widgets/app_drawer.dart';

import '../../../domain/entities/product_list_entity.dart';
import 'widgets/product_ListTile_widget.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  Future<void> _refreshProducts(BuildContext context) {
    
    return Provider.of<ProductListEntity>(
      context,
      listen: false,
    ).loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    final ProductListEntity productList = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Catálogo Produto'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed(AppRoutes.productRegister);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      drawer: const AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: ListView.builder(
              itemCount: productList.itemsCount,
              itemBuilder: (ctx, i) {
                return Column(
                  children: [
                    ProductListTileWidget(product: productList.items[i]),
                    const Divider(),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
