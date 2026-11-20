import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/widgets/meal_item.dart';
import 'package:meals/screens/meal_details.dart';

class MealsScreen extends StatelessWidget {
  final String? title;
  final List meals;
  final void Function(Meal meal) onToggleFavorite;

  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
    required this.onToggleFavorite,
  });

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(
          meal: meal,
          onToggleFavorite: onToggleFavorite, // odovzdanie funkcie ďalej
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // obsah obrazovky – buď zoznam jedál alebo prázdna správa
    Widget content = ListView.builder(
      itemCount: meals.length,
      itemBuilder: (ctx, index) {
        return MealItem(
          meal: meals[index],
          onSelectMeal: (meal) {
            _selectMeal(ctx, meal);
          },
        );
      },
    );

    if (meals.isEmpty) {
      content = Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Ups... nič tu nie je!',
              style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
            const SizedBox(height: 16),
            Text(
              'Skúste vybrať inú kategóriu!',
              style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onBackground,
                  ),
            ),
          ],
        ),
      );
    }

    // ak nie je nastavený title (napr. pri Favorites v TabsScreen),
    // zobraz len obsah bez Scaffoldu a AppBaru.
    if (title == null) {
      return content;
    }

    // inak zobraz obrazovku so Scaffoldom a AppBarom
    return Scaffold(
      appBar: AppBar(title: Text(title!)),
      body: content,
    );
  }
}
