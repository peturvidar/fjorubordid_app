import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart';
import '../models/drink_model.dart';
import '../models/food_model.dart';
import '../models/order_model.dart';
import 'api_constants.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<FoodModel>?> getFoodItems() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.foodEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<FoodModel> _foodModel = foodModelFromJson(response.body);
        return _foodModel;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<DrinkModel>?> getDrinkItems() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.drinkEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<DrinkModel> _drinkModel = drinkModelFromJson(response.body);
        return _drinkModel;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<List<OrderModel>?> getOrderItems() async {
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.orderItemEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<OrderModel> _orderModel = orderModelFromJson(response.body);
        return _orderModel;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  Future<OrderModel> increaseQuantityOrderItemFood(
      OrderModel orderModel) async {
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl +
          ApiConstants.increaseQuantityOrderItemFoodEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "orderItemId": orderModel.orderItemId,
        "foodId": orderModel.foodId,
        "quantity": orderModel.quantity,
        "unitPrice": orderModel.unitPrice,
        "description": orderModel.description,
        "name": orderModel.name
      }),
    );
    if (response.statusCode == 201) {
      return OrderModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create order.');
    }
  }

  Future<OrderModel> decreaseQuantityOrderItemFood(
      OrderModel orderModel) async {
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl +
          ApiConstants.decreaseQuantityOrderItemFoodEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "orderItemId": orderModel.orderItemId,
        "foodId": orderModel.foodId,
        "quantity": orderModel.quantity,
        "unitPrice": orderModel.unitPrice,
        "description": orderModel.description,
        "name": orderModel.name
      }),
    );
    if (response.statusCode == 201) {
      return OrderModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create order.');
    }
  }

  Future<OrderModel> increaseQuantityOrderItemDrink(
      OrderModel orderModel) async {
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl +
          ApiConstants.increaseQuantityOrderItemDrinkEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "orderItemId": orderModel.orderItemId,
        "drinkId": orderModel.drinkId,
        "quantity": orderModel.quantity,
        "unitPrice": orderModel.unitPrice,
        "description": orderModel.description,
        "name": orderModel.name
      }),
    );
    if (response.statusCode == 204) {
      return OrderModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create order.');
    }
  }

  Future<OrderModel> decreaseQuantityOrderItemDrink(
      OrderModel orderModel) async {
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl +
          ApiConstants.decreaseQuantityOrderItemDrinkEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "orderItemId": orderModel.orderItemId,
        "drinkId": orderModel.drinkId,
        "quantity": orderModel.quantity,
        "unitPrice": orderModel.unitPrice,
        "description": orderModel.description,
        "name": orderModel.name
      }),
    );
    if (response.statusCode == 204) {
      return OrderModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create order.');
    }
  }

  Future<FoodModel> createOrderItemFood(FoodModel foodModel) async {
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.orderItemFoodEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        //"orderItemId": foodModel.orderItemId,
        "foodId": foodModel.foodId,
        "quantity": foodModel.quantity,
        "unitPrice": foodModel.unitPrice,
        "description": foodModel.description,
        "name": foodModel.name
      }),
    );

    if (response.statusCode == 201) {
      return FoodModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create order.');
    }
  }

  Future<DrinkModel> createOrderItemDrink(DrinkModel drinkModel) async {
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.orderItemDrinkEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        "drinkId": drinkModel.drinkId,
        "quantity": drinkModel.quantity,
        "unitPrice": drinkModel.unitPrice,
        "description": drinkModel.description,
        "name": drinkModel.name
      }),
    );

    if (response.statusCode == 201) {
      return DrinkModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create order.');
    }
  }

  Future getTotalPrice() async {
    List totalPrice = [];
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.orderItemEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<OrderModel> _orderModel = orderModelFromJson(response.body);
        for (final d in _orderModel) {
          totalPrice.add(d.unitPrice);
        }
        return totalPrice;
      }
    } catch (e) {
      log(e.toString());
    }
  }

  Future deleteOrderItem(int id) async {
    Response res = await http.delete(
        Uri.parse('https://096d-157-157-77-147.eu.ngrok.io/api/orderitem/$id'));
    if (res.statusCode == 200) {
      if (kDebugMode) {
        print("deleted");
      }
    } else {
      throw "failed to delete item";
    }
  }

  Future deleteAllOrderItems() async {
    Response res = await http.delete(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.orderItemEndpoint));
    if (res.statusCode == 200) {
      if (kDebugMode) {
        print("all items deleted");
      }
    } else {
      throw "failed to delete all items";
    }
  }
}
