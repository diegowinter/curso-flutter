import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/product_item.dart';

class ProductGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    final products = productsProvider.items;
    return GridView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: products.length,
      itemBuilder: (ctx, index) => ProductItem(products[index]),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10
      ),
    );
  }
}