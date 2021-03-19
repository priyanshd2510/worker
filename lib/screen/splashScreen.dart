import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import './mainpage.dart';

class splashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash: 'assets/images/appicon-removebg-preview.png',
      duration: 200,
      splashIconSize: 430,
      nextScreen: MainPage(),
      splashTransition: SplashTransition.fadeTransition,
      backgroundColor: Colors.indigo,
    );;
  }
}
