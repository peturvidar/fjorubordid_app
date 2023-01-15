import 'package:fjorubordid_app_final_version/widgets/set_quantity_buttons.dart';
import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../theme/colors.dart';
import '../utils/api_services.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/category_widget.dart';
import '../widgets/checkout_button.dart';
import '../widgets/header_image.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final _apiService = ApiService();
  late List? totalPrice = [];
  List<OrderModel> _orderModel = [];

  @override
  void initState() {
    super.initState();
    _getData();
    _getTotalPrice();
  }

  //Get data from API
  void _getData() async {
    _orderModel = (await _apiService.getUserOrderItems());
    setState(() {});
    _stackElements();
  }

  //Finds multiple elements from order items and stacks them together to display them on order page
   void _stackElements() {
    final stackedElements = <String, OrderModel>{};
    for (final item in _orderModel) {
      final key = '${item.foodId}-${item.drinkId}';
      if (stackedElements.containsKey(key)) {
        _updateStackedItem(stackedElements[key]!, item);
      } else {
        stackedElements[key] = item;
      }
    }
    setState(() {
      _orderModel = stackedElements.values.toList();
    });
  }

  void _updateStackedItem(OrderModel stacked, OrderModel item) {
    stacked.quantity += item.quantity;
    stacked.unitPrice += item.unitPrice;
  }

  //Get total price of order items
  void _getTotalPrice() async {
    totalPrice = (await _apiService.getTotalPrice())!;
    Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  }

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
            const HeaderImage("assets/images/checkout.jpg"),
            const SizedBox(
              height: 25,
            ),
            Container(
              //Displays list of categories
              child: CategoryWidget().listCategories(),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              margin: const EdgeInsets.only(left: 15, right: 15),
              child: const Text(
                "Pöntun",
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: cardColor),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            //Get a list of order items from api and display them
            Expanded(
              child: _orderModel.isEmpty
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : ListView.builder(
                      shrinkWrap: true,
                      itemCount: _orderModel.length,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: const EdgeInsets.only(
                              bottom: 10, left: 20, right: 20),
                          decoration: BoxDecoration(
                            color: cardColor,
                            borderRadius: BorderRadius.circular(10),
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
                                    Text(
                                      '${_orderModel[index].name.toString()}\n',
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: blueGrey,
                                          fontSize: 16.0,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    Text(
                                      '${_orderModel[index].description.toString()}\n',
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: grey, fontSize: 14.0),
                                    ),
                                    Text(
                                      '${_orderModel[index].unitPrice}.-kr',
                                      maxLines: 1,
                                      style: const TextStyle(
                                          color: blueGrey, fontSize: 16.0),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 130,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    //Button to decrease quantity of order item,
                                    // deletes instance of object in order items and refreshed state of order items
                                    DecreaseQuantityButton(decreaseOnTap: () {
                                      if (_orderModel[index].orderItemId > 0) {
                                        _apiService
                                            .decreaseQuantityOrderItem(
                                                _orderModel[index])
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
                                    Text(
                                      "${_orderModel[index].quantity}",
                                      style: const TextStyle(
                                          color: black, fontSize: 24.0),
                                    ),
                                    const SizedBox(
                                      width: 5.0,
                                    ),
                                    //Button to increase quantity of order item,
                                    // creates a new object of selected object in order items and refreshed
                                    // state of order items
                                    IncreaseQuantityButton(increaseOnTap: () {
                                      if (_orderModel[index].foodId > 0) {
                                        _apiService
                                            .increaseQuantityOrderItemFood(
                                                _orderModel[index])
                                            .whenComplete(() {
                                          setState(() {
                                            _getData();
                                            _getTotalPrice();
                                          });
                                        });
                                      } else {
                                        _apiService
                                            .increaseQuantityOrderItemDrink(
                                                _orderModel[index])
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
                              //Button to delete all instances of selected object from order items list
                              ClipRRect(
                                borderRadius: BorderRadius.circular(25.0),
                                child: Container(
                                  color: primary,
                                  child: IconButton(
                                    icon:
                                        const Icon(Icons.delete, color: black),
                                    style: const ButtonStyle(),
                                    onPressed: () {
                                      if (_orderModel[index].foodId > 0) {
                                        _apiService
                                            .deleteOrderItem(
                                                _orderModel[index].foodId)
                                            .whenComplete(() {
                                          setState(() {
                                            totalPrice?.removeAt(index);
                                            _orderModel.removeAt(index);
                                          });
                                        });
                                      } else {
                                        _apiService
                                            .deleteOrderItem(
                                                _orderModel[index].drinkId)
                                            .whenComplete(() {
                                          setState(() {
                                            totalPrice?.removeAt(index);
                                            _orderModel.removeAt(index);
                                          });
                                        });
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }),
            ),
            //Total sum of order items, calls getTotalSum function to calculate sum
            Container(  //Total amount of order items
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
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: cardColor),
                    ),
                    Text(
                      "${getTotalSum()}\.-kr",
                      style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 20,
                          color: cardColor),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30,
                ),
                //Checkout button to finalize order, has no other function at the moment other then
                //deleting all order items and leaves a message
                CheckOutButton(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return const AlertDialog(
                            title: Text(
                                "Pöntunin þín hefur verið afgreitt, takk fyrir nota þessa prufu útgáfu af Fjöruborðs appinu"),
                            titleTextStyle: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: black,
                                fontSize: 20),
                          );
                        });
                    _apiService
                        .deleteAllOrderItems()
                        .whenComplete(() => setState(() {
                              totalPrice?.clear();
                              _orderModel.clear();
                            }));
                  },
                  title: "Greiða",
                )
              ]),
            )
          ],
        ),
      ),
    );
  }

  //Get total sum of order items
  getTotalSum() {
    if (totalPrice!.isNotEmpty) {
      var sum = totalPrice!.reduce((a, b) => a + b);
      return sum;
    } else {
      return 0;
    }
  }
}
