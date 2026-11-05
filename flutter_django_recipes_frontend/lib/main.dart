import "package:flutter/material.dart";
import "package:flutter_django_recipes_frontend/login_page.dart";
import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FlutterSplashScreen(
        splashScreenBody: Scaffold(
          backgroundColor: Color.fromARGB(255,247, 241, 230),
          body: Center(child: Image.asset("assets/Logo.png")
          ),
        ),
        duration: Duration(seconds: 3),
        nextScreen: LoginPage()),
    );
  }
}