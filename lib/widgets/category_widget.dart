import 'package:flutter/material.dart';
import '../models/categories/category_drink.dart';
import '../models/categories/category_food.dart';
import '../models/categories/category_order.dart';
import '../models/category_model.dart';

//Widget that displays list of categories in the app each has an on tap redirect to name screen route
class CategoryWidget{

  listCategories() {
    List<Widget> foods = List.generate(
        categoryFood.length, (index) => CategoryFood(data: categoryFood[index]));
    List<Widget> drinks = List.generate(categoryDrinks.length,
            (index) => CategoryDrinks(data: categoryDrinks[index]));
    List<Widget> order = List.generate(categoryOrder.length,
            (index) => CategoryOrder(data: categoryOrder[index]));

    var categories = foods + drinks + order;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.only(bottom: 5, left: 15),
      child: Row(children: categories),
    );
  }
}