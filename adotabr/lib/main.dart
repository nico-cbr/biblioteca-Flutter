import 'package:adotabr/pages/settingsPage.dart';
import 'package:flutter/material.dart';
import 'pages/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, });

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SettingsPage(),
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade100,
        appBarTheme: AppBarTheme(
          foregroundColor: Colors.grey.shade100,
          backgroundColor: Colors.indigo.shade900,
           titleTextStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w500, 
          color: Colors.amber.shade50
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20)
            )
          )
        )
      ),
    );
  }
}