// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:shop_2023/src/core/ui/theme/app_theme.dart';
import 'package:shop_2023/src/core/utls/app_routes.dart';
import 'package:shop_2023/src/pages/home/home_page.dart';

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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vamos Cozinhar?',
      theme: MyAppTheme.themeData,
      initialRoute: AppRoutes.home,
      routes: {
        AppRoutes.home: (ctx) => HomePageApp(title: widget.title),
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
    );
  }
}
