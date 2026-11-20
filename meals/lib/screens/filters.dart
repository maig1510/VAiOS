import 'package:flutter/material.dart';
import 'package:meals/models/filter.dart';

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.currentFilters});

  final Map<Filter, bool> currentFilters;

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFreeFilterSet = false;
  var _lactoseFreeFilterSet = false;
  var _vegetarianFilterSet = false;
  var _veganFilterSet = false;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilterSet = widget.currentFilters[Filter.glutenFree]!;
    _lactoseFreeFilterSet = widget.currentFilters[Filter.lactoseFree]!;
    _vegetarianFilterSet = widget.currentFilters[Filter.vegetarian]!;
    _veganFilterSet = widget.currentFilters[Filter.vegan]!;
  }

  // pomocná metóda, ktorá vráti jeden SwitchListTile
  Widget _buildSwitch(
    String title,
    String subtitle,
    bool value,
    void Function(bool isChecked) onChanged,
  ) {
    return SwitchListTile(
      value: value,
      onChanged: onChanged,
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      subtitle: Text(
        subtitle,
        style: Theme.of(context).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
            ),
      ),
      activeColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: const EdgeInsets.only(left: 34, right: 22),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) return;

        Navigator.of(context).pop({
          Filter.glutenFree: _glutenFreeFilterSet,
          Filter.lactoseFree: _lactoseFreeFilterSet,
          Filter.vegetarian: _vegetarianFilterSet,
          Filter.vegan: _veganFilterSet,
        });
      },
      child: Scaffold(
        appBar: AppBar(title: const Text('Vaše filtre')),
        body: Column(children: [
          _buildSwitch('Bezlepkové', 'Zobraziť iba bezlepkové jedlá.', _glutenFreeFilterSet,
            (isChecked) => setState(() => _glutenFreeFilterSet = isChecked)),
          _buildSwitch('Bez laktózy', 'Zobraziť iba jedlá bez laktózy.', _lactoseFreeFilterSet,
            (isChecked) => setState(() => _lactoseFreeFilterSet = isChecked)),
          _buildSwitch('Vegetariánske', 'Zobraziť iba vegetariánske jedlá.', _vegetarianFilterSet,
            (isChecked) => setState(() => _vegetarianFilterSet = isChecked)),
          _buildSwitch('Vegánske', 'Zobraziť iba vegánske jedlá.', _veganFilterSet,
            (isChecked) => setState(() => _veganFilterSet = isChecked)),
        ]),
      ),
    );
  }
}
