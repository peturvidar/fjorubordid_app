import 'package:flutter/material.dart';

import '../../theme/colors.dart';



class CategoryFood extends StatelessWidget {
  const CategoryFood({ Key? key, required this.data, this.selected = false,}) : super(key: key);
  final data;
  final bool selected;


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.of(context).pushNamed("screens/foodscreen");
      },
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.only(right: 10),
        width: 90,
        height: 50,
        decoration: BoxDecoration(
          color: selected ? primary : cardColor,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: shadowColor.withOpacity(0.05),
              spreadRadius: .5,
              blurRadius: .5,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(data["icon"], size: 17, color: selected ? Colors.white : darker),
            const SizedBox(width: 7,),
            Text(data["name"], maxLines: 1, overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 13, color: selected ? Colors.white : darker),
            )
          ],
        ),
      ),
    );
  }
}