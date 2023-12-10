import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/providers/filters_provider.dart';
import 'package:meals/providers/meals_provider.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);

  bool toggleMealFavouriteStatus(Meal meal) {
    final mealIsFavourite = state.contains(meal);

    if (mealIsFavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }

    state = [];
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>((ref) {
  return FavouriteMealsNotifier();
});

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (activeFilters[Filter.glutenFree]! && meal.isGlutenFree) {
      return false;
    }
    if (activeFilters[Filter.lactoseFree]! && meal.isLactoseFree) {
      return false;
    }
    return true;
  }).toList();
});
