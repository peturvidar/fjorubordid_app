import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/colors.dart';
import '../utils/api_constants.dart';
import 'food_screen.dart';
import 'sign_up_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

enum LoginStatus { notSignIn, signIn }

class _LoginScreenState extends State<LoginScreen> {
  LoginStatus _loginStatus = LoginStatus.notSignIn;

  late String email, password;
  final _key = GlobalKey<FormState>();

  bool _secureText = true;

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      login();
    }
  }

  login() async {
    //SharedPreferences preferences = await SharedPreferences.getInstance();
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndPoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
        }));

    final data = jsonDecode(response.body);
    String authToken = data['token'];

    if (response.statusCode == 200) {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FoodScreen()),
        );
        savePref(authToken);
      });
      loginToast("Innskráning tókst");
    } else if (response.statusCode == 400) {
      loginToast("Lykilorð eða netfang vitlaust skráð");
    } else {
      loginToast("Innskráning gekk ekki");
    }
  }

  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 3,
        backgroundColor:
            toast == "Innskráning tókst" ? Colors.green : Colors.red,
        textColor: Colors.white);
  }

  savePref(String authToken) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      preferences.setString("auth_token", authToken);
      //preferences.commit();
    });
  }

  var value;

  getPref() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      value = preferences.getInt("value");

      _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
    });
  }

  @override
  void initState() {
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(15.0),
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: Colors.black,
                child: Form(
                  key: _key,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      const SizedBox(
                        height: 40,
                      ),
                      const SizedBox(
                        height: 50,
                        child: Text(
                          "Innskráning",
                          style: TextStyle(color: Colors.white, fontSize: 30.0),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),

                      //card for Email TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Netfang getur ekki verið tómt";
                            }
                          },
                          onSaved: (e) => email = e!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: const InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.person, color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Netfang"),
                        ),
                      ),

                      // Card for password TextFormField
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Lykilorð getur ekki verið tómt";
                            }
                          },
                          obscureText: _secureText,
                          onSaved: (e) => password = e!,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            labelText: "Lykilorð",
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.phonelink_lock,
                                  color: Colors.black),
                            ),
                            suffixIcon: IconButton(
                              onPressed: showHide,
                              icon: Icon(_secureText
                                  ? Icons.visibility_off
                                  : Icons.visibility),
                            ),
                            contentPadding: const EdgeInsets.all(18),
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 12,
                      ),

                      const ElevatedButton(
                        onPressed: null,
                        child: Text(
                          "Gleymt lykilorð?",
                          style: TextStyle(
                              color: Colors.white, fontWeight: FontWeight.bold),
                        ),
                      ),

                      const Padding(
                        padding: EdgeInsets.all(14.0),
                      ),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          SizedBox(
                            height: 44.0,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primary),
                                onPressed: () {
                                  check();
                                },
                                child: const Text(
                                    style: TextStyle(color: Colors.black),
                                    "Innskráning")),
                          ),
                          SizedBox(
                            height: 44.0,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: primary),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const SignUpScreen()),
                                  );
                                },
                                child: const Text(
                                    style: TextStyle(color: Colors.black),
                                    "Nýskráning")),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
