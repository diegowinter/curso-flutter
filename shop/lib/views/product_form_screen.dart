import 'package:flutter/material.dart';

class ProductFormScreen extends StatefulWidget {
  @override
  _ProductFormScreenState createState() => _ProductFormScreenState();
}

class _ProductFormScreenState extends State<ProductFormScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Formulário Produto'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(child:
          ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Título'
                ),
                textInputAction: TextInputAction.next,
              )
            ],
        ),),
      ),
    );
  }
}