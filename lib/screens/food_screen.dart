import 'package:fjorubordid_app_final_version/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/categories/category_drink.dart';
import '../models/categories/category_order.dart';
import '../models/category_model.dart';
import '../models/food_model.dart';
import '../utils/api_services.dart';
import '../models/categories/category_food.dart';
import 'order_screen.dart';

class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  late List<FoodModel>? _foodModel = [];
  @override
  void initState() {
    super.initState();
    _getData();
  }

  void _getData() async {
    _foodModel = (await ApiService().getFoodItems())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Fjöruborðið",
          style: GoogleFonts.lato(
              fontWeight: FontWeight.bold, fontSize: 30, color: Colors.black),
        ),
        actions:  <Widget>[
          IconButton(icon: const Icon(Icons.logout, color: Colors.black),  onPressed:(){
            Navigator.of(context).pushNamed("screens/loginscreen");
          })
        ],

      ),

      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/images/background.jpg"),
              fit: BoxFit.cover,
            )),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 10,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              height: 150,
              decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                        "assets/images/humar.jpg",
                      ))),
            ),
            const SizedBox(
              height: 25,
            ),
            Container(
              margin: const EdgeInsets.only(left: 0),
              child: listCategories(),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: const Text(
                "Matseðill",
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: cardColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _foodModel?.length,
                  itemBuilder: (context, index) {
                    return Container(
                      margin: const EdgeInsets.only(
                          bottom: 10, left: 20, right: 20),
                      //padding: const EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: cardColor,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: shadowColor.withOpacity(0.1),
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: const Offset(
                                0, 1), // changes position of shadow
                          ),
                        ],
                      ),
                      child: GestureDetector(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            if (_foodModel![index].unitPrice > 6300)
                              const Image(
                                height: 100,
                                width: 100,
                                image: AssetImage('assets/images/humar.jpg'),
                              ),
                            if (_foodModel![index].name == "Humarsúpa")
                              const Image(
                                height: 100,
                                width: 100,
                                image: AssetImage('assets/images/súpa.jpg'),
                              ),
                            if (_foodModel![index].unitPrice == 6250)
                              const Image(
                                height: 100,
                                width: 100,
                                image: AssetImage('assets/images/lamb.jpg'),
                              ),
                            if (_foodModel![index].name == "Grænmetisréttur")
                              const Image(
                                height: 100,
                                width: 100,
                                image: AssetImage('assets/images/grænn.JPG'),
                              ),
                            if (_foodModel![index].unitPrice == 1650)
                              const Image(
                                height: 100,
                                width: 100,
                                image: AssetImage('assets/images/dessert.jpg'),
                              ),
                            if (_foodModel![index].name == "Samloka")
                              const Image(
                                height: 100,
                                width: 100,
                                image: AssetImage('assets/images/samloka.jpg'),
                              ),
                            if (_foodModel![index].name == "Kjúklinganaggar")
                              const Image(
                                height: 100,
                                width: 100,
                                image: AssetImage('assets/images/naggar.jpg'),
                              ),
                            SizedBox(
                              width: 130,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 5.0,
                                  ),
                                  RichText(
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 1,
                                    text: TextSpan(
                                      text:
                                      '${_foodModel![index].name.toString()}\n',
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  ),
                                  RichText(
                                    maxLines: 1,
                                    text: TextSpan(
                                      text:
                                      '${_foodModel![index].description.toString()}\n',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 14.0),
                                    ),
                                  ),
                                  RichText(
                                    maxLines: 1,
                                    text: TextSpan(
                                      text:
                                      "${_foodModel![index].unitPrice}.-kr",
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(20.0),
                              // backgroundColor: Colors.orange,
                              child: Container(
                                color: Colors.orange,
                                child: IconButton(
                                  icon: const Icon(Icons.shopping_basket,
                                      color: Colors.black),
                                  style: ButtonStyle(
                                    backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.orange),
                                    foregroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Colors.black),
                                  ),
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title:
                                            const Text("Vöru bætt í körfu"),
                                            titleTextStyle: const TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black,
                                                fontSize: 20),
                                            actionsOverflowButtonSpacing: 20,
                                            actions: [
                                              ElevatedButton(
                                                  style:
                                                  ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                      primary),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                  child: const Text(
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                      "Halda áfram að versla")),
                                              ElevatedButton(
                                                  style:
                                                  ElevatedButton.styleFrom(
                                                      backgroundColor:
                                                      primary),
                                                  onPressed: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                            const OrderScreen()));
                                                  },
                                                  child: const Text(
                                                      style: TextStyle(
                                                          color: Colors.black),
                                                      "Skoða körfu")),
                                            ],
                                          );
                                        });
                                    ApiService().createOrderItemFood(
                                        _foodModel![index]);
                                  },
                                  //child: Text('add'),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }

                //children: List.generate(_foodModel!.length,(int index) => DisplayItem(data: _foodModel![index])),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}

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