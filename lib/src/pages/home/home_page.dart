// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_2023/src/core/providers/product_list.dart';
import 'package:shop_2023/src/pages/home/widgets/gridview_products_widget.dart';

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

  incrementCounter() {
    setState(() {});
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
        ],
      ),
      body: GridviewProductsWidget(showFavoriteOnly: _showFavoriteOnly),
    );
  }
}
