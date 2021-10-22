import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

showCustomSnackBar(BuildContext context, String messege) {
  Fluttertoast.showToast(
    msg: messege,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey[900],
    textColor: Colors.white,
  );
}
