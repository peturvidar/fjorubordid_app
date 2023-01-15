import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../screens/login_screen.dart';
import '../theme/colors.dart';

//Appbar widget shared for all screens, contains title of app and button that redirects to login screen
class AppBarWidget extends StatelessWidget implements PreferredSizeWidget {
  final double? height;
  const AppBarWidget({
    super.key,
    this.height = kToolbarHeight,
  });
  @override
  Size get preferredSize => Size.fromHeight(height!);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: primary,
      elevation: 0,
      centerTitle: true,
      title: Text(
        "Fjöruborðið",
        style: GoogleFonts.lato(
            fontWeight: FontWeight.bold, fontSize: 30, color: black),
      ),
      actions: <Widget>[
        IconButton(
            icon: const Icon(Icons.logout, color: black),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const LoginScreen()),
              );
            })
      ],
    );
  }
}
