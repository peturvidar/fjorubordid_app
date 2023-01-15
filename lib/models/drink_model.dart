import 'dart:convert';


//Drink model for converting Json response from API
List<DrinkModel> drinkModelFromJson(String str) =>
    List<DrinkModel>.from(json.decode(str).map((x) => DrinkModel.fromJson(x)));

String drinkModelToJson(List<DrinkModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class DrinkModel {
  int drinkId;
  String name;
  int unitPrice;
  int quantity;
  String description;
  String imagePath;

  DrinkModel(
      {required this.name,
      required this.description,
      required this.drinkId,
      required this.quantity,
      required this.unitPrice,
      required this.imagePath});

  factory DrinkModel.fromJson(Map<String, dynamic> json) {
    return DrinkModel(
      drinkId: json['drinkId'],
      name: json['name'],
      unitPrice: json['unitPrice'],
      quantity: json['quantity'],
      description: json['description'],
      imagePath: json['imagePath']
    );
  }
  Map<String, dynamic> toJson() => {
        "drinkId": drinkId,
        "name": name,
        "unitPrice": unitPrice,
        "quantity": quantity,
        "description": description,
        "imagePath": imagePath,
      };
}
