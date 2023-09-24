// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:shop_2023/src/domain/entities/product_entity.dart';

class ProductsDetailPage extends StatelessWidget {
  const ProductsDetailPage({super.key});

  @override
  Widget build(BuildContext context) {
  
   final ProductEntity productRegister = ModalRoute.of(context)!.settings.arguments as ProductEntity;


    return Scaffold(
      appBar: AppBar(
        title: Text(productRegister.name),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: double.infinity,
              child: Image.network(
                productRegister.imageUrl,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'R\$ ${productRegister.price}',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              width: double.infinity,
              child: Text(
                productRegister.description,
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
