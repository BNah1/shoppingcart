import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/bloc/category/category_bloc.dart';
import 'package:shoppingcart/bloc/category/category_state.dart';
import 'package:shoppingcart/bloc/product/product_bloc.dart';
import 'package:shoppingcart/screen/route.dart';
import 'package:shoppingcart/screen/splash_screen.dart';
import 'bloc/cart/cart_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => CartBloc()),
        BlocProvider(create: (context) => ProductBloc()),
        BlocProvider(create: (context) => CategoryBloc())
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          onGenerateRoute: Routes.generateRoute,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const SplashScreen()
      ),
    );
  }
}
