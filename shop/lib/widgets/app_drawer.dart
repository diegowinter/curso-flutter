import 'package:flutter/material.dart';
import 'package:shop/utils/app_routes.dart';

class AppDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: Text('Bem-vindo, user!'),
            automaticallyImplyLeading: false,
          ),
          SizedBox(height: 5),
          ListTile(
            leading: Icon(Icons.shopping_bag_outlined),
            title: Text('Loja'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.HOME
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.list_alt),
            title: Text('Pedidos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.ORDERS
              );
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}