import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

Future setDefaultOrientation() async {
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitDown, DeviceOrientation.portraitUp]);
}

Future setLandscapeOrientation() async {
  await SystemChrome.setPreferredOrientations(
      [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight]);
}

void launchURL(url) async =>
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';

void setStatusBarColor() {
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.black,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarDividerColor: Colors.black));
}

void hideStatusBar() {
  if (kDebugMode) {
    print("Hiding status bar");
  }
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

void resetStatusbar() {
  SystemChrome.restoreSystemUIOverlays();
}
