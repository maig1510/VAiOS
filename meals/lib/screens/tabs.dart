import 'package:flutter/material.dart';
import 'package:meals/screens/categories.dart';
import 'package:meals/screens/meals.dart';
import 'package:meals/screens/filters.dart'; // import FiltersScreen
import 'package:meals/models/meal.dart';
import 'package:meals/models/filter.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

// východiskové filtre
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarian: false,
  Filter.vegan: false,
};

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];

  // Aktuálne zvolené filtre
  Map<Filter, bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context)
      ..clearSnackBars() // zruší predchádzajúce hlásenie
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 4),
        ),
      );
  }

  void _toggleMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);

    setState(() {
      if (isExisting) {
        _favoriteMeals.remove(meal);
        _showInfoMessage('Jedlo bolo odstránené z obľúbených.');
      } else {
        _favoriteMeals.add(meal);
        _showInfoMessage('Jedlo bolo pridané medzi obľúbené!');
      }
    });
  }

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  // Filtrovanie jedál podľa aktívnych filtrov
  List<Meal> get _availableMeals {
    return dummyMeals.where((meal) {
      if (_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) return false;
      if (_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) return false;
      if (_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) return false;
      if (_selectedFilters[Filter.vegan]! && !meal.isVegan) return false;
      return true;
    }).toList();
  }

  // Otvorenie FiltersScreen z Draweru
  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // zatvorí Drawer

    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _selectedFilters, // odosielame aktuálne filtre
          ),
        ),
      );

      setState(() {
        _selectedFilters = result ?? kInitialFilters; // aktualizácia filtrov
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = CategoriesScreen(
      onToggleFavorite: _toggleMealFavoriteStatus,
      availableMeals: _availableMeals, // posielame prefiltrované jedlá
    );
    String activePageTitle = 'Kategórie';

    if (_selectedPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals, // odovzdanie obľúbených jedál
        onToggleFavorite: _toggleMealFavoriteStatus,
      );
      activePageTitle = 'Vaše obľúbené';
    }

    return Scaffold(
      appBar: AppBar(title: Text(activePageTitle)),
      body: activePage,
      drawer: MainDrawer(onSelectScreen: _setScreen), // prepojenie s Drawerom
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Kategórie'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Obľúbené'),
        ],
      ),
    );
  }
}
