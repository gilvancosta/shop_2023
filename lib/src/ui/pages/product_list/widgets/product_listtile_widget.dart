// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/entities/product_list_entity.dart';
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
                onPressed: () {
                  Navigator.of(context).pushNamed(
                    AppRoutes.productRegister,
                    arguments: product,
                  );
                },
                color: Theme.of(context).primaryColor,
                icon: const Icon(
                  Icons.edit,
                )),
            IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (ctx) => AlertDialog(
                      title: const Text('Excluir Produto'),
                      content: const Text('Tem certeza?'),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(false);
                          },
                          child: const Text('Não'),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop(true);
                          },
                          child: const Text('Sim'),
                        ),
                      ],
                    ),
                  ).then((value) {
                    if (value) {
                      Provider.of<ProductListEntity>(context, listen: false).removeProduct(product);
                    }
                  });
                },
                color: Colors.red,
                icon: const Icon(
                  Icons.delete,
                )),
          ],
        ),
      ),
    );
  }
}
