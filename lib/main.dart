import 'package:finstagram/pages/home/home_page.dart';
import 'package:finstagram/pages/login_page.dart';
import 'package:finstagram/pages/register_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: {
        "login": (ctx) => LoginPage(),
        "register": (ctx) => RegisterPage(),
        "home": (ctx) => HomePage()
      },
      initialRoute: "home",
      title: 'Finstagram',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
        fontFamily: "AJ-Kunheing-02"
      ),
      home: const LoginPage(),
    );
  }
}