import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//import '../models/product.dart';
import '../widgets/produtct_item.dart';
import '../providers/products.dart';

class ProductOverviewScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    // items é o getter que tem no provider.
    //final List<Product> loadedProducts = Provider.of<Products>(context).items;
    final productsProvider = Provider.of<Products>(context);
    final products = productsProvider.items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: products.length,
        itemBuilder: (ctx, index) => ProductItem(products[index]),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10
        ),
      )
    );
  }
}