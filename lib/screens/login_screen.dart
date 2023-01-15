import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../theme/colors.dart';
import '../utils/api_constants.dart';
import '../utils/services.dart';
import 'food_screen.dart';
import 'sign_up_screen.dart';

//Login screen gives user option to choose register page if user doesnt have account already.
//Uses sharedpreference to store token in cache for automatic login when exiting and re-entering app.
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
  final _services = Services();

  Future<SharedPreferences> _getPreferences() async {
    return await SharedPreferences.getInstance();
  }

  showHide() {
    setState(() {
      _secureText = !_secureText;
    });
  }

  check() {
    final form = _key.currentState;
    if (form!.validate()) {
      form.save();
      _login();
    }
  }
  //Post request to API to login user and receive token, stores token in shared preference
  void _login() async {
    final preferences = await _getPreferences();
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.loginEndPoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "email": email,
          "password": password,
        }));
    if (response.statusCode == 400) {
      _services.loginToast("Lykilorð eða netfang vitlaust skráð");
    }
    final data = jsonDecode(response.body);
    String authToken = data['token'];

    if (response.statusCode == 200) {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const FoodScreen()),
        );
        _savePref(authToken);
      });
      _services.loginToast("Innskráning tókst");
    } else {
      _services.loginToast("Innskráning gekk ekki");
    }
  }
  //Stores token
  void _savePref(String authToken) async {
    final preferences = await _getPreferences();
    setState(() {
      preferences.setString("authToken", authToken);
    });
  }
  //Gets token
  void _getPref() async {
    final preferences = await _getPreferences();
    int? value = preferences.getInt("value");
    _loginStatus = value == 1 ? LoginStatus.signIn : LoginStatus.notSignIn;
  }

  @override
  void initState() {
    super.initState();
    _getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: black,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(15.0),
          children: <Widget>[
            Center(
              child: Container(
                padding: const EdgeInsets.all(8.0),
                color: black,
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
                          style: TextStyle(color: cardColor, fontSize: 30.0),
                        ),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Netfang getur ekki verið tómt";
                            } else if (Services.isEmailValid(e) == false) {
                              return "Verður að vera gilt netfang";
                            } else {
                              return null;
                            }
                          },
                          onSaved: (e) => email = e!,
                          style: const TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: const InputDecoration(
                              prefixIcon: Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.person, color: black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Netfang"),
                        ),
                      ),
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Lykilorð getur ekki verið tómt";
                            }
                            return null;
                          },
                          obscureText: _secureText,
                          onSaved: (e) => password = e!,
                          style: const TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                            labelText: "Lykilorð",
                            prefixIcon: const Padding(
                              padding: EdgeInsets.only(left: 20, right: 15),
                              child: Icon(Icons.phonelink_lock, color: black),
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
                              color: cardColor, fontWeight: FontWeight.bold),
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
                                    style: TextStyle(color: black),
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
                                    style: TextStyle(color: black),
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
