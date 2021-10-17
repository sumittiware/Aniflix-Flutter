import 'package:aniflix/providers/animeprovider.dart';
import 'package:aniflix/providers/bannerprovider.dart';
import 'package:aniflix/providers/episodeprovider.dart';
import 'package:aniflix/providers/searchprovider.dart';
import 'package:aniflix/providers/songprvider.dart';
import 'package:aniflix/views/auth/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  // await setDefaultOrientation();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: BannerProvider()),
        ChangeNotifierProvider.value(value: AnimeProvider()),
        ChangeNotifierProvider.value(value: SongProvider()),
        ChangeNotifierProvider.value(value: SearchProvider()),
        ChangeNotifierProvider.value(value: EpisodeProvider())
      ],
      child: MaterialApp(
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
            fontFamily: "Ubuntu",
            brightness: Brightness.dark,
            canvasColor: Colors.black,
            colorScheme: const ColorScheme.dark(secondary: Colors.red),
            iconTheme: const IconThemeData(color: Colors.white),
          ),
          home: const SignUpPage()),
    );
  }
}
