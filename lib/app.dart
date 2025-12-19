import 'package:flutter/material.dart';
import 'package:match_aura/screens/splash_screen.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'openSans Regular'
      ),
      home: const SplashScreen(),
    );
  }
}
