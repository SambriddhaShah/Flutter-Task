import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lipstick/utils/customColors.dart';

class ToastMessage {
  static showMessage(String message) {
    Fluttertoast.showToast(
        backgroundColor: CustomColors.PrimaryColor,
        msg: message,
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        fontSize: 15);
  }

  static ScaffoldFeatureController scaffoldMessenger(
          BuildContext context, String message) =>
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: CustomColors.PrimaryColor,
        content: Container(
          alignment: Alignment.center,
          height: MediaQuery.of(context).size.height * .2,
          child: Text(
            message,
            style: const TextStyle(
                fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
          ),
        ),
      ));
}
