import 'package:flutter/material.dart';

import '../widgets/product_grid.dart';

class ProductOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // items é o getter que tem no provider.
    //final List<Product> loadedProducts = Provider.of<Products>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
      ),
      body: ProductGrid()
    );
  }
}

