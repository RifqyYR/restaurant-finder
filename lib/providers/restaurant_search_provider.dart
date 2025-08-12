import 'package:flutter/material.dart';
import 'package:submission_restaurant_app_1/data/api/api_services.dart';
import 'package:submission_restaurant_app_1/state/restaurant_search_state.dart';

class RestaurantSearchProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  RestaurantSearchProvider(this._apiServices);

  RestaurantSearchState _resultState = RestaurantSearchNoneState();

  RestaurantSearchState get resultState => _resultState;

  Future<void> fetchSearchedRestaurantList(String? query) async {
    try {
      _resultState = RestaurantSearchLoadingState();
      notifyListeners();

      final result = await _apiServices.getSearchedRestaurantList(query ?? '');

      if (result.error) {
        _resultState = RestaurantSearchErrorState(result.error.toString());
        notifyListeners();
      } else {
        _resultState = RestaurantSearchLoadedState(result.restaurants);
        notifyListeners();
      }
    } on Exception {
      _resultState = RestaurantSearchErrorState(
        "Terjadi kesalahan, silahkan coba lagi",
      );
      notifyListeners();
    }
  }
}
