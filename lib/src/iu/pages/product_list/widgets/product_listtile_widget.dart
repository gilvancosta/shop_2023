// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../../app_routes.dart';
import '../../../../domain/entities/product_entity.dart';


class ProductListTileWidget extends StatelessWidget {
  final ProductEntity product;

  const ProductListTileWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: NetworkImage(product.imageUrl),
      ),
      title: Text(product.name),
      trailing: SizedBox(
        width: 100,
        child: Row(
          children: [
            IconButton(
                onPressed: () {},
                color: Theme.of(context).primaryColor,
                icon: const Icon(
                  Icons.edit,
                )),
            IconButton(
                onPressed: () {},
                color: Colors.red,
                icon: const Icon(
                  Icons.delete,
                )),
          ],
        ),
      ),
      onTap: () {
        Navigator.of(context).pushReplacementNamed(
          AppRoutes.home,
        );
      },
    );
  }
}
