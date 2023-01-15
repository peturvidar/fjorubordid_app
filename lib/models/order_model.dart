import 'dart:convert';

//Order model for converting Json response from API
List<OrderModel> orderModelFromJson(String str) =>
    List<OrderModel>.from(json.decode(str).map((x) => OrderModel.fromJson(x)));

String orderModelToJson(List<OrderModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrderModel {
  int orderItemId;
  int foodId;
  int drinkId;
  int unitPrice;
  int quantity;
  String description;
  String name;

  OrderModel({
    required this.orderItemId,
    required this.foodId,
    required this.drinkId,
    required this.unitPrice,
    required this.quantity,
    required this.description,
    required this.name,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderItemId: json['orderItemId'],
      foodId: json['foodId'],
      drinkId: json['drinkId'],
      unitPrice: json['unitPrice'],
      quantity: json['quantity'],
      description: json['description'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() => {
        "orderItemId": orderItemId,
        "foodId": foodId,
        "drinkId": drinkId,
        "unitPrice": unitPrice,
        "quantity": quantity,
        "name": name,
        "description": description,
      };
}
