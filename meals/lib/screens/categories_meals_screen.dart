import 'package:flutter/material.dart';
import '../components/meal_item.dart';
import '../models/category.dart';
import '../models/meal.dart';

class CategoriesMealsScreen extends StatelessWidget {
  final List<Meal> meals;
  const CategoriesMealsScreen(this.meals);
  
  @override
  Widget build(BuildContext context) {
    // Para receber o argumento ao fazer a navegação
    final category = ModalRoute.of(context).settings.arguments as Category;
    final categoryMeals = meals.where((meal) {
      return meal.categories.contains(category.id);
    }).toList();
    return Scaffold(
      appBar: AppBar(
        title: Text(category.title),
      ),
      body: Center(
        child: ListView.builder(
          itemCount: categoryMeals.length,
          itemBuilder: (ctx, index) {
            return MealItem(categoryMeals[index]);
          }
        ),
      ),
    );
  }
}