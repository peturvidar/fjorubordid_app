import 'package:cached_network_image/cached_network_image.dart';
import 'package:fjorubordid_app_final_version/widgets/add_order_buttons.dart';
import 'package:flutter/material.dart';
import '../models/drink_model.dart';
import '../theme/colors.dart';
import '../utils/api_constants.dart';
import '../utils/api_services.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/header_image.dart';

class DrinkScreen extends StatefulWidget {
  const DrinkScreen({Key? key}) : super(key: key);

  @override
  State<DrinkScreen> createState() => _DrinkScreenState();
}

class _DrinkScreenState extends State<DrinkScreen> {
  final _apiService = ApiService();
  List<DrinkModel> _drinkModel = []; //list of drink items

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
              //Displays list of categories
              child:CategoryWidget().listCategories(),
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
            //Get drink items from api and displays them
            FutureBuilder<List<DrinkModel>>(
              future: _apiService.getDrinkItems(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  if (snapshot.hasData) {
                    _drinkModel = snapshot.data!;
                    return _buildDrinksList(); //Display drinks widget
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

  Widget _buildDrinksList() {
    return Expanded(
      child: ListView.builder(
          shrinkWrap: true,
          itemCount: _drinkModel.length,
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
                        child: CachedNetworkImage(
                          imageUrl:
                              '${ApiConstants.baseUrl + ApiConstants.imageEndpoint}${_drinkModel[index].imagePath}',
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
                            Text(
                              '${_drinkModel[index].name.toString()}\n',
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              style: const TextStyle(
                                  color: blueGrey,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${_drinkModel[index].description.toString()}\n',
                              maxLines: 1,
                              style:
                                  const TextStyle(color: grey, fontSize: 14.0),
                            ),
                            Text(
                              '${_drinkModel[index].unitPrice}.-kr',
                              maxLines: 1,
                              style: const TextStyle(
                                  color: blueGrey, fontSize: 16.0),
                            ),
                          ],
                        ),
                      ),
                      //Add to order button, gives option to keep shopping or go to order
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
                                  });
                              _apiService
                                  .addDrinkItemToOrder(_drinkModel[index]);
                            },
                          ),
                        ),
                      ),
                    ])));
          }),
    );
  }
}
