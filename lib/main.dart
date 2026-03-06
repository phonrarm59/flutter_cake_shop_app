// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';
import 'package:flutter_cake_shop_app/splash_screen_ui.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(
    flutterCakeShopApp(),
  );
}

class flutterCakeShopApp extends StatefulWidget {
  const flutterCakeShopApp({super.key});

  @override
  State<flutterCakeShopApp> createState() => _flutterCakeShopAppState();
}

class _flutterCakeShopAppState extends State<flutterCakeShopApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreenUi(),
      theme: ThemeData(
        textTheme:
            GoogleFonts.notoSansThaiTextTheme(
              Theme.of(context).textTheme,
        ),
      ),
    );
  }
}
