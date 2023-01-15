import 'package:flutter/material.dart';
import '../../theme/colors.dart';
//Button for drink category
class CategoryDrinks extends StatelessWidget {
  const CategoryDrinks({
    Key? key,
    this.data,
    this.selected = false,
  }) : super(key: key);
  final data;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector( //On tap sends user to drink screen
      onTap: () {
        Navigator.of(context).pushNamed("screens/drinkScreen");
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(right: 10),
        width: 90,
        height: 50,
        decoration: BoxDecoration(
          color: selected ? primary : cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(data["icon"],
                size: 17, color: selected ? Colors.white : darkGrey),
            const SizedBox(
              width: 7,
            ),
            Text(
              data["name"],
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontSize: 13, color: selected ? Colors.white : darkGrey),
            )
          ],
        ),
      ),
    );
  }
}
