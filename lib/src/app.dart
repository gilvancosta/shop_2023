// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_2023/src/domain/entities/cart_entity.dart';


import 'package:shop_2023/src/core/ui/theme/app_theme.dart';
import 'package:shop_2023/src/ui/app_routes.dart';

import 'package:shop_2023/src/ui/pages/home/home_page.dart';
import 'package:shop_2023/src/ui/pages/product_detail/products_detail_page.dart';


import 'domain/entities/order_list_entity.dart';
import 'domain/entities/product_list_entity.dart';
import 'ui/pages/cart/cart_page.dart';
import 'ui/pages/order/orders_page.dart';
import 'ui/pages/product_list/product_list_page.dart';
import 'ui/pages/product_register/product_register_page.dart';

class MyApp extends StatefulWidget {
  final String title;
  const MyApp({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => ProductListEntity(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartEntity(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderListEntity(),
        ),
      ],
      //  return CounterProvider(

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vamos Cozinhar?',
        theme: MyAppTheme.themeData,
        initialRoute: AppRoutes.home,
        // initialRoute: AppRoutes.counter,
        routes: {
          AppRoutes.home: (ctx) => HomePageApp(title: widget.title),
          AppRoutes.productDetail: (ctx) => const ProductsDetailPage(),
          AppRoutes.cart: (ctx) => const CartPage(),
          AppRoutes.orders: (ctx) => const OrdersPage(),
          AppRoutes.product: (ctx) => const ProductListPage(),
          AppRoutes.productRegister: (ctx) => const ProductRegisterPage(),
        },

        onGenerateRoute: (settings) {
          if (settings.name == '/alguma-coisa') {
            return null;
          } else if (settings.name == '/outra-coisa') {
            return null;
          } else {
            return MaterialPageRoute(builder: (_) {
              return HomePageApp(title: widget.title);
            });
          }
        },
        // funciona tipo fosse uma página 404
        onUnknownRoute: (settings) {
          return MaterialPageRoute(builder: (_) {
            return HomePageApp(title: widget.title);
          });
        },
      ),
    );
  }
}
