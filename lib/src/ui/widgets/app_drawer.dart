import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_2023/src/domain/controllers/auth/auth_controller.dart';
import 'package:shop_2023/src/ui/pages/order/orders_page.dart';

import '../app_routes.dart';
import '../pages/custom_route.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Bem vindo Usuário!'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.shop),
            title: const Text('Loja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.auth_or_home,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.payment),
            title: const Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.orders,
              );
              /*    Navigator.of(context).pushReplacement(
                CustomRoute(
                  builder: (ctx) => const OrdersPage(),
                ), */
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Gereciar Produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.product,
              );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: const Text('Sair'),
            onTap: () {
              Provider.of<AuthController>(context, listen: false).logout();

              Navigator.of(context).pushReplacementNamed(
                AppRoutes.auth_or_home,
              );
            },
          ),
        ],
      ),
    );
  }
}
