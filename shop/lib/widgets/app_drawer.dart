import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/auth.dart';
import '../utils/app_routes.dart';

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
                AppRoutes.AUTH_HOME
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
          ListTile(
            leading: Icon(Icons.edit),
            title: Text('Gerenciar produtos'),
            onTap: () {
              Navigator.of(context).pushReplacementNamed(
                AppRoutes.PRODUCTS
              );
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Sair'),
            onTap: () {
              Provider.of<Auth>(context, listen: false).logout();
            },
          ),
          Divider(),
        ],
      ),
    );
  }
}