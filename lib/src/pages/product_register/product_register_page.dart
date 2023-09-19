import 'package:flutter/material.dart';


class ProductRegisterPage extends StatefulWidget {
  const ProductRegisterPage({super.key});

  @override
  State<ProductRegisterPage> createState() => _ProductRegisterPageState();
}

class _ProductRegisterPageState extends State<ProductRegisterPage> {
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produtos'),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          ),],
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: formKey,
          child: ListView(
            children: [
              TextFormField(),
              TextFormField(),
              TextFormField(),
              const Row(
                children: [

                ],
                
              )
            ],
          ),
        ),
      ),
    );
  }
}
