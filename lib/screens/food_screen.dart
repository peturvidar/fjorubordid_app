import 'package:cached_network_image/cached_network_image.dart';
import 'package:fjorubordid_app_final_version/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/food_model.dart';
import '../utils/api_constants.dart';
import '../utils/api_services.dart';
import '../widgets/add_order_buttons.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/header_image.dart';


//Screen that gets and displays food items in scrollable container from API,
// with option to add item to order
class FoodScreen extends StatefulWidget {
  const FoodScreen({Key? key}) : super(key: key);

  @override
  State<FoodScreen> createState() => _FoodScreenState();
}

class _FoodScreenState extends State<FoodScreen> {
  final _apiService = ApiService();
  List<FoodModel> _foodModel = [];//Empty list of food items
  final addThousandSeparator = NumberFormat.decimalPattern();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primary,
      appBar: const AppBarWidget(),
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
              height: 35,
            ),
            const HeaderImage("assets/images/humar.jpg"),
            const SizedBox(
              height: 25,
            ),
            Container(
              //Displays list of categories with on tap redirection to named screen
              child: CategoryWidget().listCategories(),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: const Text(
                "Matseðill",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: cardColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //Get a list of food items from api and display them with Builder
            FutureBuilder<List<FoodModel>>(
              future: _apiService.getFoodItems(),//api get request
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    _foodModel = snapshot.data!;
                    return _buildFoodList(); //Food list widget
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}");
                  }
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ],
        ),
      ),
    );
  }

  //Widget to build the card for displaying the food objects.
  Widget _buildFoodList() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _foodModel.length,
          itemBuilder: (context, index) {
            return Container(
                constraints: const BoxConstraints(maxWidth: 100),
                margin: const EdgeInsets.only(bottom: 10, left: 20, right: 20),
                decoration: BoxDecoration(
                  color: cardColor,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: GestureDetector(
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                      Container(
                        margin: const EdgeInsets.only(top: 10, bottom: 10),
                        width: 100,
                        height: 70,
                        child: CachedNetworkImage( //Displays image from http request and stores in cache for faster reload
                          imageUrl:
                              '${ApiConstants.baseUrl + ApiConstants.imageEndpoint}${_foodModel[index].imagePath}',
                        ),
                      ),
                      SizedBox(
                        width: 130,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 5.0,
                            ),
                            Text(//Name of food object
                              '${_foodModel[index].name.toString()}\n',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: blueGrey,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(//Food object description
                              '${_foodModel[index].description.toString()}\n',
                              maxLines: 1,
                              style:
                                  const TextStyle(color: grey, fontSize: 14.0),
                            ),
                            Text(//Drink object price
                              '${addThousandSeparator.format(_foodModel[index].unitPrice)}.-kr',
                              maxLines: 1,
                              style: const TextStyle(
                                  color: blueGrey, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      //Add to order button. Creates a new instance of selected food object in order items table,
                      // after press a pop up appears to  give option to keep shopping or go to order
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: Container(
                          color: primary,
                          child: IconButton(
                            icon:
                                const Icon(Icons.shopping_basket, color: black),
                            style: const ButtonStyle(),
                            onPressed: () {
                              showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return const AddOrderButtons();
                                  }); //Http post request to create new instance of food item in order items
                              _apiService.addFoodItemToOrder(_foodModel[index]);
                            },
                          ),
                        ),
                      ),
                    ])));
          }),
    );
  }
}
