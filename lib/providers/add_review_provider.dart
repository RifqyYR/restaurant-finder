import 'package:flutter/material.dart';
import 'package:submission_restaurant_app_1/data/api/api_services.dart';
import 'package:submission_restaurant_app_1/state/add_review_state.dart';

class AddReviewProvider extends ChangeNotifier {
  final ApiServices _apiServices;

  AddReviewProvider(this._apiServices);

  AddReviewState _resultState = AddReviewNoneState();

  AddReviewState get resultState => _resultState;

  void resetState() {
    _resultState = AddReviewNoneState();
    notifyListeners();
  }

  Future<void> addReview(String id, String name, String review) async {
    try {
      _resultState = AddReviewLoadingState();
      notifyListeners();

      final result = await _apiServices.addReview(id, name, review);
      if (result.error) {
        _resultState = AddReviewErrorState(error: result.message);
        notifyListeners();
      } else {
        _resultState = AddReviewLoadedState(message: result.message);
        notifyListeners();
      }
    } catch (e) {
      _resultState = AddReviewErrorState(
        error: "Terjadi kesalahan, silahkan coba lagi",
      );
      notifyListeners();
    }
  }
}
