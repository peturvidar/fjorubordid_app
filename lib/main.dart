import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/drink_screen.dart';
import 'screens/food_screen.dart';
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
  var auth_token = prefs.getString('auth_token');

   runApp(MaterialApp(
      debugShowCheckedModeBanner: false,
      home: auth_token == null ? const LoginScreen() : const FoodScreen(),
       routes: {
         "screens/signupscreen": (context) => const SignUpScreen(),
         "screens/loginscreen": (context) => const LoginScreen(),
         "screens/foodscreen": (context) => const FoodScreen(),
         "screens/drinkscreen": (context) => const DrinkScreen(),
         "screens/orderscreen": (context) => const OrderScreen(),
       }
  )
  );
}
/*
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  var auth_token = prefs.getString('auth_token');
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]).then((value) => runApp(const MyApp()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: auth_token == null ? const LoginScreen() : const FoodScreen(),
        initialRoute: "screens/loginscreen",
        routes: {
          "screens/signupscreen": (context) => const SignUpScreen(),
          "screens/loginscreen": (context) => const LoginScreen(),
          "screens/foodscreen": (context) => const FoodScreen(),
          "screens/drinkscreen": (context) => const DrinkScreen(),
          "screens/orderscreen": (context) => const OrderScreen(),
        });
  }
}*/