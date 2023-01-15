import 'package:flutter/material.dart';
import '../screens/order_screen.dart';
import '../theme/colors.dart';


//Buttons for pop up when adding item to order with option to keep shopping or going straight to order screen
class AddOrderButtons extends StatelessWidget {
  const AddOrderButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title:
      const Text("Vöru bætt í körfu"),
      titleTextStyle: const TextStyle(
          fontWeight: FontWeight.bold,
          color: black,
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
                    color: black),
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
                    color: black),
                "Skoða körfu")),
      ],
    );
  }
}