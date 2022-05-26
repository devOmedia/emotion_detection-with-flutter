import 'package:easy_splash_screen/easy_splash_screen.dart';
import 'package:emotion_detection/screens/home_screen.dart';
import 'package:flutter/material.dart';

class FlashScreen extends StatelessWidget {
  const FlashScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return EasySplashScreen(
      logo: Image.asset('images/theater.png'),
      title: Text(
        "Check Mental Health",
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      gradientBackground: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.004, 1],
          colors: [Color(0xffe100ff), Color(0xFF8e2de2)]),
      showLoader: true,
      loadingText: Text("Loading..."),
      navigator: HomeScreen(),
      durationInSeconds: 5,
    );
  }
}
