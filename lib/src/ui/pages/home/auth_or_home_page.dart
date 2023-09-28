import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop_2023/src/domain/controllers/auth/auth_controller.dart';

import '../auth/auth_page.dart';
import 'home_page.dart';

class AuthOrHomePage extends StatelessWidget {
  const AuthOrHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AuthController auth = Provider.of(context);
    // return auth.isAuth ? const ProductsOverviewPage() : const AuthPage();
    return FutureBuilder(
      future: auth.tryAutoLogin(),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.error != null) {
          return const Center(
            child: Text('Ocorreu um erro!'),
          );
        } else {
          return auth.isAuth ? const HomePageApp(title: 'Minha Loja') : const AuthPage();
        }
      },
    );
  }
}
