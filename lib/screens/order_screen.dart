import 'package:fjorubordid_app_final_version/widgets/set_quantity_buttons.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/categories/category_drink.dart';
import '../models/categories/category_order.dart';
import '../models/category_model.dart';
import '../models/order_model.dart';
import '../theme/colors.dart';
import '../utils/api_services.dart';
import '../models/categories/category_food.dart';
import '../widgets/checkout_button.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  late List? totalPrice = [];
  late List<OrderModel>? _orderModel = [];

  @override
  void initState() {
    super.initState();
    _getData();
    _getTotalPrice();
  }

  void _getTotalPrice() async {
    totalPrice = (await ApiService().getTotalPrice())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

  void _getData() async {
    _orderModel = (await ApiService().getOrderItems())!;
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
                        "assets/images/checkout.jpg",
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
                "Pöntun",
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
                  itemCount: _orderModel?.length,
                  itemBuilder: (context, index) {
                    if (_orderModel!.isEmpty) {
                      return const Center(
                          child: Text(
                        'Karfan þín er tóm',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18.0),
                      ));
                    } else {
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          mainAxisSize: MainAxisSize.max,
                          children: [
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
                                          '${_orderModel![index].name.toString()}\n',
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
                                          '${_orderModel![index].description.toString()}\n',
                                      style: const TextStyle(
                                          color: Colors.grey, fontSize: 14.0),
                                    ),
                                  ),
                                  RichText(
                                    maxLines: 1,
                                    text: TextSpan(
                                      text:
                                          "${_orderModel![index].unitPrice}.-kr",
                                      style: TextStyle(
                                          color: Colors.blueGrey.shade800,
                                          fontSize: 16.0),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 130,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  DecreaseQuantityButton(decreaseOnTap: () {
                                    if (_orderModel![index].foodId > 0) {
                                      ApiService()
                                          .decreaseQuantityOrderItemFood(
                                              _orderModel![index])
                                          .whenComplete(() {
                                        setState(() {
                                          _getData();
                                          _getTotalPrice();
                                        });
                                      });
                                    } else {
                                      ApiService()
                                          .decreaseQuantityOrderItemDrink(
                                              _orderModel![index])
                                          .whenComplete(() {
                                        setState(() {
                                          _getData();
                                          _getTotalPrice();
                                        });
                                      });
                                    }
                                  }),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  RichText(
                                      maxLines: 1,
                                      text: TextSpan(
                                        text: "${_orderModel![index].quantity}",
                                        style: const TextStyle(
                                            color: Colors.black87,
                                            fontSize: 24.0),
                                      )),
                                  const SizedBox(
                                    width: 5.0,
                                  ),
                                  IncreaseQuantityButton(increaseOnTap: () {
                                    if (_orderModel![index].foodId > 0) {
                                      ApiService()
                                          .increaseQuantityOrderItemFood(
                                              _orderModel![index])
                                          .whenComplete(() {
                                        setState(() {
                                          _getData();
                                          _getTotalPrice();
                                        });
                                      });
                                    } else {
                                      ApiService()
                                          .increaseQuantityOrderItemDrink(
                                              _orderModel![index])
                                          .whenComplete(() {
                                        setState(() {
                                          _getData();
                                          _getTotalPrice();
                                        });
                                      });
                                    }
                                  })
                                ],
                              ),
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(25.0),
                              // backgroundColor: Colors.orange,
                              child: Container(
                                color: primary,
                                child: IconButton(
                                  icon: const Icon(Icons.delete,
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
                                    ApiService()
                                        .deleteOrderItem(
                                            _orderModel![index].orderItemId)
                                        .whenComplete(() {
                                      setState(() {
                                        totalPrice?.removeAt(index);
                                        _orderModel?.removeAt(index);
                                      });
                                    });
                                  },
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }),
            ),
            Container(
              padding: const EdgeInsets.only(left: 30, right: 30),
              child: Column(children: [
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      "Heildarupphæð",
                      style:
                          TextStyle(fontWeight: FontWeight.w600, fontSize: 20, color: cardColor),
                    ),
                    Text(
                      "${getTotalSum()}\.-kr",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 20, color: cardColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                CheckOutButton(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text(
                                "Pöntunin þín hefur verið afgreitt, takk fyrir nota þessa prufu útgáfu af Fjöruborðsappinu"),
                            titleTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 20),
                          );
                        });
                    ApiService()
                        .deleteAllOrderItems()
                        .whenComplete(() => setState(() {
                              totalPrice?.clear();
                              _orderModel?.clear();
                            }));
                  },
                  title: "Greiða",
                )
              ]),
            )
          ],
        ),
      ),
      // bottomNavigationBar: getBottomBar(),
    );
  }

  getTotalSum() {
    if (totalPrice!.isNotEmpty) {
      var sum = totalPrice!.reduce((a, b) => a + b);
      return sum;
    } else {
      return 0;
    }
  }

  listCategories() {
    List<Widget> foods = List.generate(categoryFood.length,
        (index) => CategoryFood(data: categoryFood[index]));
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
