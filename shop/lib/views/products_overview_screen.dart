import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shop/utils/app_routes.dart';
import 'package:shop/widgets/app_drawer.dart';

import '../widgets/product_grid.dart';
import '../widgets/badge.dart';

import '../providers/cart.dart';
import '../providers/products.dart';

enum FilterOptions {
  Favorite,
  All
}

class ProductOverviewScreen extends StatefulWidget {

  @override
  _ProductOverviewScreenState createState() => _ProductOverviewScreenState();
}

class _ProductOverviewScreenState extends State<ProductOverviewScreen> {
  bool _showFavoriteOnly = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    // carregar os produtos
    Provider.of<Products>(context, listen: false).loadProducts().then((_) {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // items é o getter que tem no provider.
    //final List<Product> loadedProducts = Provider.of<Products>(context).items;

    return Scaffold(
      appBar: AppBar(
        title: Text('Minha Loja'),
        actions: [
          Consumer<Cart>(
            child: IconButton(
              icon: Icon(Icons.shopping_cart),
              onPressed: () {
                Navigator.of(context).pushNamed(
                  AppRoutes.CART
                );
              },
            ),
            builder: (ctx, cart, child) => Badge(
              value: cart.totalItemsCount.toString(),
              child: child
            ),
          ),
          PopupMenuButton(
            icon: Icon(Icons.more_vert),
            onSelected: (selectedValue) {
              setState(() {
                selectedValue == FilterOptions.Favorite 
                  ? _showFavoriteOnly = true
                  : _showFavoriteOnly = false;          
              });
            },
            itemBuilder: (_) => [
              PopupMenuItem(
                child: Text('Exibir somente favoritos'),
                value: FilterOptions.Favorite,
              ),
              PopupMenuItem(
                child: Text('Exibir todos'),
                value: FilterOptions.All,
              ),
            ]
          )
        ],
      ),
      body: _isLoading 
        ? Center(
            child: CircularProgressIndicator(),
          )
        : ProductGrid(_showFavoriteOnly),
      drawer: AppDrawer(),
    );
  }
}

