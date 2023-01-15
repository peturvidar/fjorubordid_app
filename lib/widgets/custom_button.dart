import 'package:flutter/material.dart';
import '../theme/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton(
      {Key? key,
      required this.onTap,
      this.title = "",
      this.width = double.infinity,
      this.height = 45,
      this.icon,
      this.disableButton = false,
      this.isLoading = false,
      this.radius = 10})
      : super(key: key);
  final GestureTapCallback onTap;
  final String title;
  final double width;
  final double height;
  final double radius;
  final IconData? icon;
  final bool disableButton;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disableButton,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: disableButton ? primary.withOpacity(0.3) : primary,
            ),
            width: width,
            height: height,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: isLoading
                    ? [
                        const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: black,
                              strokeWidth: 3,
                            ))
                      ]
                    : (icon == null)
                        ? [
                            Text(
                              title,
                              style: const TextStyle(
                                  color: black, fontWeight: FontWeight.w600),
                            )
                          ]
                        : [
                            Icon(
                              icon,
                              size: 23,
                              color: disableButton
                                  ? black.withOpacity(0.3)
                                  : black,
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              title,
                              style: const TextStyle(
                                  color: black, fontWeight: FontWeight.w600),
                            )
                          ])),
      ),
    );
  }
}
