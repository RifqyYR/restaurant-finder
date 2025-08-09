import 'package:submission_restaurant_app_1/data/models/category.dart';
import 'package:submission_restaurant_app_1/data/models/customer_review.dart';
import 'package:submission_restaurant_app_1/data/models/menus.dart';

class Restaurant {
  String? id;
  String? name;
  String? description;
  String? city;
  String? pictureId;
  List<Category>? categories;
  Menus? menus;
  double? rating;
  List<CustomerReview>? customerReviews;

  Restaurant({
    this.id,
    this.name,
    this.description,
    this.city,
    this.pictureId,
    this.categories,
    this.menus,
    this.rating,
    this.customerReviews,
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"],
    name: json["name"],
    description: json["description"],
    city: json["city"],
    pictureId: json["pictureId"],
    categories:
        json["categories"] == null
            ? []
            : List<Category>.from(
              json["categories"].map((x) => Category.fromJson(x)),
            ),
    menus: json["menus"] == null ? null : Menus.fromJson(json["menus"]),
    rating: json["rating"]?.toDouble(),
    customerReviews:
        json["customerReviews"] == null
            ? []
            : List<CustomerReview>.from(
              json["customerReviews"].map((x) => CustomerReview.fromJson(x)),
            ),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "city": city,
    "pictureId": pictureId,
    "categories":
        categories == null
            ? []
            : List<dynamic>.from(categories!.map((x) => x.toJson())),
    "menus": menus?.toJson(),
    "rating": rating,
    "customerReviews":
        customerReviews == null
            ? []
            : List<dynamic>.from(customerReviews!.map((x) => x.toJson())),
  };
}
