// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_2023/src/models/product_list_model.dart';

import 'package:shop_2023/src/core/ui/theme/app_theme.dart';
import 'package:shop_2023/src/core/utls/app_routes.dart';

import 'package:shop_2023/src/pages/home/home_page.dart';
import 'package:shop_2023/src/pages/product/products_detail_page.dart';

import 'models/cart_model.dart';
import 'models/order_list_model.dart';
import 'pages/cart/cart_page.dart';
import 'pages/order/orders_page.dart';
import 'pages/product/product_page.dart';
import 'pages/product_register/product_register_page.dart';

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
          create: (ctx) => ProductListModel(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => CartModel(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => OrderListModel(),
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
          AppRoutes.product: (ctx) => const ProductPage(),
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
