import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter { glutenFree, lactoseFree }

class FiltersNnotifier extends StateNotifier<Map<Filter, bool>> {
  FiltersNnotifier()
      : super({Filter.glutenFree: false, Filter.lactoseFree: false});

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isActive) {
    // state[filter] = isActive;
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNnotifier, Map<Filter, bool>>(
        (ref) => FiltersNnotifier());
