import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../core/utls/app_routes.dart';
import '../../core/widgets/app_drawer.dart';

import '../../models/product_list_model.dart';
import 'widgets/product_ListTile_widget.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ProductListModel productList = Provider.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro Produto'),
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
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: ListView.builder(
            itemCount: productList.itemsCount,
            itemBuilder: (ctx, i) {
              return Column(
                children: [ProductListTileWidget(product: productList.items[i]), const Divider()],
              );
            }),
      ),
    );
  }
}
