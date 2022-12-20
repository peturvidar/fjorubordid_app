import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;

import '../theme/colors.dart';
import '../utils/api_constants.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String firstName, email, lastName, password;
  final _key =  GlobalKey<FormState>();

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

    final response = await http.post(Uri.parse(ApiConstants.baseUrl + ApiConstants.signUpEndPoint),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        //"userName": userName,
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "password": password,
      }));
   /* //final data = jsonDecode(response.body);
    //String id = data['id'];*/

    if (response.statusCode == 200) {
      setState(() {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => const LoginScreen()),
        );
      });
      //print(id);
      registerToast("Nýskráning tókst");
    } else if (response.statusCode == 400){
      registerToast("Notandi með þetta netfang er þegar til");
    }
    else {
      registerToast("Nýskráning mistókst");
    }
  }

  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: toast == "Nýskráning tókst" ? Colors.green : Colors.red,
        textColor: Colors.white);
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
                          "Nýskráning",
                          style: TextStyle(color: Colors.white, fontSize: 30.0),
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
                              return "Vantar nafn";
                            }
                          },
                          onSaved: (e) => firstName = e!,
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
                              labelText: "Nafn"),
                        ),
                      ),
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Vantar eftirnafn";
                            }
                          },
                          onSaved: (e) => lastName = e!,
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
                              labelText: "Eftirnafn"),
                        ),
                      ),

                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          validator: (e) {
                            if (e!.isEmpty) {
                              return "Vinsamlega sláið inn netfang";
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
                                child: Icon(Icons.email, color: Colors.black),
                              ),
                              contentPadding: EdgeInsets.all(18),
                              labelText: "Netfang"),
                        ),
                      ),
                      Card(
                        elevation: 6.0,
                        child: TextFormField(
                          obscureText: _secureText,
                          onSaved: (e) => password = e!,
                          style: const TextStyle(
                            color: Colors.black,
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
                                child: Icon(Icons.phonelink_lock,
                                    color: Colors.black),
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
                                style:
                                ElevatedButton.styleFrom(
                                    backgroundColor:
                                    primary),
                                onPressed: () {
                                  check();
                                },
                                child: const Text(
                                    style: TextStyle(
                                        color: Colors.black),
                                    "Nýskrá")),
                          ),
                          SizedBox(
                            height: 44.0,
                            child: ElevatedButton(
                                style:
                                ElevatedButton.styleFrom(
                                    backgroundColor:
                                    primary),
                                onPressed: () {
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => const LoginScreen()),
                                  );
                                },
                                child: const Text(
                                    style: TextStyle(
                                        color: Colors.black),
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