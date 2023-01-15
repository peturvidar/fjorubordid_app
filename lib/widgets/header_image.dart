import 'package:flutter/material.dart';
import '../theme/colors.dart';

class HeaderImage extends StatelessWidget {
  const HeaderImage(this.name, {super.key});
  final String name;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(left: 15, right: 15),
      height: 150,
      decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(fit: BoxFit.cover, image: AssetImage(name))),
    );
  }
}
