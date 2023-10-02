import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'ColorPalette.dart';
import 'loginPage.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: FirebaseOptions(apiKey: "AIzaSyBLjHNopSspzkuP3kUBWC5V9Ug3MJ70m_w", appId: "1:768297535361:web:5ae3add25e492776a34a80",messagingSenderId: "768297535361",projectId: "cakewalkpos")
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'CakeWalk Employee System',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: ColourPalette.backgroundColor,
        ),
        home:  LoginPage()
      // builder: (context, constraints) => ConstrainedBox(
      //constraints: const BoxConstraints(minWidth: 1000, minHeight: 1000),
      //),
      //),
    );
  }
}

