import 'dart:convert';

//Food model for converting Json response from API
List<FoodModel> foodModelFromJson(String str) =>
    List<FoodModel>.from(json.decode(str).map((x) => FoodModel.fromJson(x)));

String foodModelToJson(List<FoodModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FoodModel {
  int foodId;
  String name;
  String description;
  int quantity;
  int unitPrice;
  String imagePath;

  FoodModel({
    required this.foodId,
    required this.name,
    required this.description,
    required this.quantity,
    required this.unitPrice,
    required this.imagePath,
  });

  factory FoodModel.fromJson(Map<String, dynamic> json) {
    return FoodModel(
      foodId: json['foodId'],
      name: json['name'],
      description: json['description'],
      quantity: json['quantity'],
      unitPrice: json['unitPrice'],
        imagePath: json['imagePath'],
    );
  }
  Map<String, dynamic> toJson() => {
        "foodId": foodId,
        "name": name,
        "description": description,
        "quantity": quantity,
        "unitPrice": unitPrice,
          "imagePath": imagePath,
      };
}
