import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../theme/colors.dart';

class Services{

  //Pop up for successful login attempt
  loginToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor:
        toast == "Innskráning tókst" ? Colors.green : Colors.red,
        textColor: cardColor);
  }
  //Checks if inputted email by user is valid
  static bool isEmailValid(String email) {
    return RegExp(
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(email);
  }
  //Checks if input password contains at least 1 upper case letter, 1 number and is at least 6 characters long
  static bool isPasswordValid(String password) {
    return RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$')
        .hasMatch(password);
  }

  //Pop up if registration is successful
  registerToast(String toast) {
    return Fluttertoast.showToast(
        msg: toast,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor:
        toast == "Nýskráning tókst" ? Colors.green : Colors.red,
        textColor: cardColor);
  }

}