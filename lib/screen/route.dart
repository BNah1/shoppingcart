import 'package:flutter/material.dart';
import 'package:shoppingcart/screen/product/product_screen.dart';
import 'cart/cart_screen.dart';
import 'home/home_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/home':
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case '/cart':
        return MaterialPageRoute(builder: (_) => const CartScreen());
      case '/product':
        final args = settings.arguments as String; // Lấy arguments
        return MaterialPageRoute(
          builder: (_) => ProductScreen(productId: args),
        );
      default:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
    }
  }
}
