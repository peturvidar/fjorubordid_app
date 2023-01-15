import 'package:fjorubordid_app_final_version/screens/food_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/drink_screen.dart';
import 'screens/login_screen.dart';
import 'screens/order_screen.dart';
import 'screens/sign_up_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var authToken = prefs.getString('authToken');

  runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: authToken == null ? const LoginScreen() : const FoodScreen(),
      routes: {
        "screens/signupScreen": (context) => const SignUpScreen(),
        "screens/loginScreen": (context) => const LoginScreen(),
        "screens/drinkScreen": (context) => const DrinkScreen(),
        "screens/orderScreen": (context) => const OrderScreen(),
        "screens/foodScreen": (context) => const FoodScreen(),
      }));
}
