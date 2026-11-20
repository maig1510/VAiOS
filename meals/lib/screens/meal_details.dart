import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';

class MealDetailsScreen extends StatelessWidget {
  final Meal meal;
  final void Function(Meal meal) onToggleFavorite;

  const MealDetailsScreen({
    super.key,
    required this.meal,
    required this.onToggleFavorite,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              onToggleFavorite(meal); // volanie funkcie z rodiča
            },
            icon: const Icon(Icons.star),
          ),
        ],
      ),
      body: SingleChildScrollView( // umožní posúvanie
        child: Column(
          children: [
            Image.network(
              meal.imageUrl,
              width: double.infinity,
              height: 300,
              fit: BoxFit.cover,
              // ak sa obrázok nenačíta, zobrazí sa náhradná plocha rovnakej veľkosti
              errorBuilder: (context, error, stackTrace) => Container(
                height: 300,
                width: double.infinity,
                color: Theme.of(context).colorScheme.primaryContainer,
                child: const Icon(Icons.no_photography, size: 64),
              ),
            ),
            const SizedBox(height: 14),
            Text(
              'Ingrediencie',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            // tu zobrazíme zoznam ingrediencií
            ...meal.ingredients.map(
              (ingredient) => Text(
                ingredient,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onBackground,
                    ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'Postup',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            const SizedBox(height: 14),
            ...meal.steps.map(
              (step) => Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 12,
                ),
                child: Text(
                  step,
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(
                        color: Theme.of(context)
                            .colorScheme
                            .onBackground,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
