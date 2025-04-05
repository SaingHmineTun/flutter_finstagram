import 'package:finstagram/pages/home/home_page.dart';
import 'package:finstagram/pages/login_page.dart';
import 'package:finstagram/pages/register_page.dart';
import 'package:finstagram/services/firebase_service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  GetIt.instance.registerSingleton<FirebaseService>(FirebaseService());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    FirebaseService firebaseService = GetIt.instance.get<FirebaseService>();
    return FutureBuilder(
      future: firebaseService.alreadySignIn(),
      builder: (ctx, snapshot) {
        if (snapshot.hasData) {
          String initialRoute = snapshot.data! ? "home" : "login";
          return MaterialApp(
            routes: {
              "login": (ctx) => LoginPage(),
              "register": (ctx) => RegisterPage(),
              "home": (ctx) => HomePage(),
            },
            initialRoute: initialRoute,
            title: 'Finstagram',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.yellow),
              fontFamily: "AJ-Kunheing-02",
            ),
            home: const LoginPage(),
          );
        } else {
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
