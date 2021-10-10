import 'package:aniflix/config.dart';
import 'package:aniflix/views/auth/authscreen.dart';
import 'package:aniflix/views/home/detail.dart';
import 'package:aniflix/views/home/tabsceen.dart';
import 'package:flutter/material.dart';

void main() async {
  // await setDefaultOrientation();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Aniflix',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.grey,
            appBarTheme: const AppBarTheme(
              color: Colors.black,
            ),
            inputDecorationTheme: const InputDecorationTheme(
              hintStyle: TextStyle(color: Colors.blueGrey),
              labelStyle: TextStyle(color: Colors.white),
            ),
            fontFamily: "Bebas Neue",
            brightness: Brightness.dark,
            canvasColor: Colors.black,
            accentColor: Colors.red,
            accentIconTheme: const IconThemeData(color: Colors.white)),
        home: const SignUpPage());
  }
}
