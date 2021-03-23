import 'package:flutter/material.dart';
import '../models/category.dart';

class CategoriesMealsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Para receber o argumento ao fazer a navegação
    final category = ModalRoute.of(context).settings.arguments as Category;
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: Text('Receitas por categoria - ${category.id}'),
      ),
    );
  }
}