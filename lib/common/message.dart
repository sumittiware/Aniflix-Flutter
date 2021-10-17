import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

// showCustomSnackBar(BuildContext context, String message) {
//   ScaffoldMessenger.of(context).hideCurrentSnackBar();
//   ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//     content: Text(
//       message,
//       textAlign: TextAlign.center,
//       style: const TextStyle(color: Colors.white),
//     ),
//     behavior: SnackBarBehavior.floating,
//     elevation: 4,
//     margin: const EdgeInsets.all(8),
//     backgroundColor: Colors.grey[300],
//     shape: RoundedRectangleBorder(
//       borderRadius: BorderRadius.circular(16),
//     ),
//     duration: const Duration(seconds: 5),
//   ));
// }

showCustomSnackBar(BuildContext context, String messege) {
  Fluttertoast.showToast(
    msg: messege,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.grey,
    textColor: Colors.white,
    // fontSize: 16.0
  );
}
