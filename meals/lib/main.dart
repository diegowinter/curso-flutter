import 'package:flutter/material.dart';

import 'screens/categories_meals_screen.dart';
import 'screens/meal_detail_screen.dart';
import 'utils/app_routes.dart';
import 'screens/tabs_screen.dart';
import 'screens/settings_screen.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DeliMeals',
      theme: ThemeData(
        primarySwatch: Colors.orange,
        accentColor: Colors.redAccent,
        fontFamily: 'Raleway',
        canvasColor: Color.fromRGBO(255, 180, 133, 1),
        textTheme: ThemeData.light().textTheme.copyWith(
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
        AppRoutes.HOME: (ctx) => TabsScreen(),
        AppRoutes.CATEGORIES_MEALS: (ctx) => CategoriesMealsScreen(),
        AppRoutes.MEAL_DETAIL: (ctx) => MealDetailScreen(),
        AppRoutes.SETTINGS: (ctx) => SettingsScreen()
      },
      // onGenerateRoute: (settings) {
      //   if (settings.name == '/alguma-coisa') {
      //     return null;
      //   } else if (settings.name == '/outra-coisa') {
      //     return null;
      //   } else {
      //     return MaterialPageRoute(
      //       builder: (_) {
      //         return CategoriesScreen();
      //       }
      //     );
      //   }
      // },
      // onUnknownRoute: (settings) {
      //   return MaterialPageRoute(
      //     builder: (_) {
      //       return CategoriesScreen();
      //     }
      //   );
      // },
    );
  }
}
