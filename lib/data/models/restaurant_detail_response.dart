import 'package:submission_restaurant_app_1/data/models/restaurant.dart';

class RestaurantDetailResponse {
  final bool error;
  final String message;
  final Restaurant restaurant;

  RestaurantDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  // todo-04-detail-02: dont forget to add map converter
  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> json) {
    return RestaurantDetailResponse(
      error: json["error"],
      message: json["message"],
      restaurant: Restaurant.fromJson(json["restaurant"]),
    );
  }
}
