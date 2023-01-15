import 'package:flutter/material.dart';
import 'custom_button.dart';
//Buttons used in order screen to give option to increase/decrease quantity of selected item in order.
class DecreaseQuantityButton extends StatelessWidget {
  const DecreaseQuantityButton(
      {Key? key,
      required this.decreaseOnTap,
      this.width = 40,
      this.height = 30})
      : super(key: key);
  final GestureTapCallback decreaseOnTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CustomButton(
          onTap: decreaseOnTap,
          title: "-",
          width: width,
          height: height,
          radius: 15,
        ),
        const SizedBox(
          width: 3,
        ),
      ],
    );
  }
}

class IncreaseQuantityButton extends StatelessWidget {
  const IncreaseQuantityButton(
      {Key? key,
      required this.increaseOnTap,
      this.width = 40,
      this.height = 30})
      : super(key: key);
  final GestureTapCallback increaseOnTap;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const SizedBox(
          width: 3,
        ),
        CustomButton(
            onTap: increaseOnTap,
            title: "+",
            width: width,
            height: height,
            radius: 15),
      ],
    );
  }
}
