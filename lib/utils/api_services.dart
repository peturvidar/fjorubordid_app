import 'dart:convert';
import 'dart:developer';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/drink_model.dart';
import '../models/food_model.dart';
import '../models/order_model.dart';
import 'api_constants.dart';
import 'package:http/http.dart' as http;


//Class of CRUD operations with API
class ApiService {

  //Get a list of all food items
  Future<List<FoodModel>> getFoodItems() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.foodEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var foodJson = json.decode(response.body) as List;
        List<FoodModel> _foodModel = foodJson.map((food) => FoodModel.fromJson(food)).toList();
        return _foodModel;
      } else {
        throw Exception('Failed to load food items');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  //Get a list of all drink items
  Future<List<DrinkModel>> getDrinkItems() async {
    try {
      var url = Uri.parse(ApiConstants.baseUrl + ApiConstants.drinkEndpoint);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        List<DrinkModel> _drinkModel = drinkModelFromJson(response.body);
        return _drinkModel;
      }else{
        throw Exception('Failed to load drink items');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }
  //Get a list of order items by user id
  Future<List<OrderModel>> getUserOrderItems() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.orderItemEndpoint);
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
      if (response.statusCode == 200) {
        List<OrderModel> _orderModel = orderModelFromJson(response.body);
        return _orderModel;
      }else{
        throw Exception('Failed to load order items');
      }
    } catch (e) {
      log(e.toString());
      rethrow;
    }

  }

  Future<OrderModel> increaseQuantityOrderItemFood(
      OrderModel orderModel) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl +
          ApiConstants.increaseQuantityOrderItemFoodEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
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

  Future<OrderModel> decreaseQuantityOrderItem(OrderModel orderModel) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl +
          ApiConstants.decreaseQuantityOrderItemEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
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
    if (response.statusCode == 204) {
      return OrderModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create order.');
    }
  }

  Future<OrderModel> increaseQuantityOrderItemDrink(
      OrderModel orderModel) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl +
          ApiConstants.increaseQuantityOrderItemDrinkEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
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

  Future<FoodModel> addFoodItemToOrder(FoodModel foodModel) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.orderItemFoodEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "foodId": foodModel.foodId,
        "quantity": foodModel.quantity,
        "unitPrice": foodModel.unitPrice,
        "description": foodModel.description,
        "name": foodModel.name,
        }),
    );
    if (response.statusCode == 201 || response.statusCode == 204) {
      return FoodModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create order.');
    }
  }

  Future<DrinkModel> addDrinkItemToOrder(DrinkModel drinkModel) async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    final response = await http.post(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.orderItemDrinkEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(<String, dynamic>{
        "drinkId": drinkModel.drinkId,
        "quantity": drinkModel.quantity,
        "unitPrice": drinkModel.unitPrice,
        "description": drinkModel.description,
        "name": drinkModel.name
      }),
    );

    if (response.statusCode == 201 || response.statusCode == 204) {
      return DrinkModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to create order.');
    }
  }

  Future getTotalPrice() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    List totalPrice = [];
    try {
      var url =
          Uri.parse(ApiConstants.baseUrl + ApiConstants.orderItemEndpoint);
      var response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );
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
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    final response = await http.delete(
      Uri.parse(
          "${ApiConstants.baseUrl}${ApiConstants.deleteOrderItemsById}/$id"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 204) {
      if (kDebugMode) {
        print("deleted");
      }
    } else {
      throw "failed to delete item";
    }
  }

  Future deleteAllOrderItems() async {
    final prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('authToken');
    final response = await http.delete(
      Uri.parse(ApiConstants.baseUrl + ApiConstants.orderItemEndpoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      if (kDebugMode) {
        print("all items deleted");
      }
    } else {
      throw "failed to delete all items";
    }
  }
}
