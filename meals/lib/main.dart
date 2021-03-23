import 'package:flutter/material.dart';

import 'screens/categories_screen.dart';
import 'screens/categories_meals_screen.dart';
import 'utils/app_routes.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.blue,
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255, 180, 133, 1),
        textTheme: ThemeData.dark().textTheme.copyWith(
          // Tema para ser usado em títulos
          headline6: TextStyle(
            fontSize: 20,
            fontFamily: 'RobotoCondensed'
          )
        )
      ),
      // home: CategoriesScreen(), // isso pode ser removido ao definir a rota /
      // initialRoute: '/', // pode colocar esta propriedade para definir
      routes: {
        AppRoutes.HOME: (ctx) => CategoriesScreen(),
        AppRoutes.CATEGORIES_MEALS: (ctx) => CategoriesMealsScreen()
      },
    );
  }
}
