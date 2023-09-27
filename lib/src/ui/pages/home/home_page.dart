// ignore_for_file: avoid_print
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shop_2023/src/ui/pages/home/widgets/products_gridview_widget.dart';
import '../../../domain/entities/cart_entity.dart';
import '../../../domain/entities/product_list_entity.dart';
import '../../app_routes.dart';
import '../../widgets/app_drawer.dart';

import 'widgets/iconcart_stack_widget.dart';

enum FilterOptions {
  favorite,
  all,
}

class HomePageApp extends StatefulWidget {
  final String title;

  const HomePageApp({super.key, required this.title});

  @override
  State<HomePageApp> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<HomePageApp> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    Provider.of<ProductListEntity>(
      context,
      listen: false,
    ).loadProducts().then((value) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    //  final provider = Provider.of<ProductList>(context);

    return Scaffold(
      appBar: AppBar(
        // backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        actions: [
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            itemBuilder: (context) => [
              const PopupMenuItem(value: FilterOptions.favorite, child: Text('Somente os Favoritos')),
              const PopupMenuItem(value: FilterOptions.all, child: Text('Todos')),
            ],
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorite) {
                  _showFavoriteOnly = true;
                } else {
                  _showFavoriteOnly = false;
                }
              });

              /*     if (selectedValue == FilterOptions.favorite) {
              provider.showFavoriteOnly();
              } else {
                provider.showFavoriteAll();
              }
 */
              // print('Valor: ${selectedValue.index}');
            },
          ),
          Consumer<CartEntity>(
            child: IconButton(
              onPressed: () {
                Navigator.of(context).pushNamed(AppRoutes.cart);
              },
              icon: const Icon(Icons.shopping_cart),
            ),
            builder: (ctx, cart, child) => IconCartStackWidget(
              value: cart.itemsCound.toString(),
              child: child!,
            ),
          ),
        ],
      ),
      body: _isLoading ? const Center(child: CircularProgressIndicator()) : ProductsGridViewWidget(showFavoriteOnly: _showFavoriteOnly),
      drawer: const AppDrawer(),
    );
  }
}
