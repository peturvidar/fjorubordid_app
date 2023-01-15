import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../theme/colors.dart';
import '../utils/api_constants.dart';
import '../utils/services.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String userName, email, password;
  final _key = GlobalKey<FormState>();
  final _services = Services();
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
      save();
    }
  }

  save() async {
    final response = await http.post(
        Uri.parse(ApiConstants.baseUrl + ApiConstants.signUpEndPoint),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          "userName": userName,
          "email": email,
          "password": password,
        }));

    if (response.statusCode == 200) {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      });

      _services.registerToast("Nýskráning tókst");
    } else if (response.statusCode == 400) {
      _services.registerToast("Notandi er þegar til");
    }
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
                          "Nýskráning",
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
                              return "Vantar notandanafn";
                            }
                            return null;
                          },
                          onSaved: (e) => userName = e!,
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
                              labelText: "Notandanafn"),
                        ),
                      ),
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Vinsamlega sláið inn netfang";
                            } else if (Services.isEmailValid(e) == false) {
                              return "Verður að vera gilt netfang";
                            }
                            return null;
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
                                child: Icon(Icons.email, color: black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Netfang"),
                        ),
                      ),
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          obscureText: _secureText,
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Vinsamlega sláið inn netfang";
                            } else if (Services.isPasswordValid(e) == false) {
                              return "Lykilorð verður að vera minnst 6 stafir, 1 stóran staf og 1 tölu";
                            }
                            return null;
                          },
                          onSaved: (e) => password = e!,
                          style: const TextStyle(
                            color: black,
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                          ),
                          decoration: InputDecoration(
                              suffixIcon: IconButton(
                                onPressed: showHide,
                                icon: Icon(_secureText
                                    ? Icons.visibility_off
                                    : Icons.visibility),
                              ),
                              prefixIcon: const Padding(
                                padding: EdgeInsets.only(left: 20, right: 15),
                                child: Icon(Icons.phonelink_lock, color: black),
                              ),
                              contentPadding: const EdgeInsets.all(18),
                              labelText: "Lykilorð"),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(12.0),
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
                                    style: TextStyle(color: black), "Nýskrá")),
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
                                            const LoginScreen()),
                                  );
                                },
                                child: const Text(
                                    style: TextStyle(color: black),
                                    "Innskráning")),
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
