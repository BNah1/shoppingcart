import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shoppingcart/constants/constant.dart';
import 'package:shoppingcart/screen/home/home_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    int currentYear = DateTime.now().year;
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => const HomeScreen()),
      );
    });
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          const Spacer(),
          Center(
            child: SizedBox(
              height: 100,
              width: 100,
              child: Image.asset(
                'assets/cart.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Spacer(),
          Text(
            '$currentYear. Shopping App. All rights reversed.',
            style: styleTileItem,
          ),
          const SizedBox(
            height: 100,
          )
        ],
      ),
    );
  }
}
