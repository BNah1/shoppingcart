import 'dart:async';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/bloc/cart/cart_bloc.dart';
import 'package:shoppingcart/bloc/cart/cart_state.dart';
import 'package:shoppingcart/bloc/product/product_bloc.dart';
import 'package:shoppingcart/bloc/product/product_event.dart';
import 'package:shoppingcart/constants/constant.dart';
import 'package:shoppingcart/screen/cart/cart_screen.dart';
import 'package:shoppingcart/screen/home/widget/all_products_widget.dart';
import 'package:shoppingcart/screen/home/widget/hot_products_widget.dart';
import 'package:shoppingcart/widget/loading.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  static String routeName = '/home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    Timer(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(LoadProducts()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: dColorAppBar,
          title: const Text(
            "Home",
            style: styleTileAppbar,
          ),
          actions: [
            _isLoading
                ? const SizedBox.shrink()
                : BlocBuilder<CartBloc, CartState>(builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: badges.Badge(
                        badgeStyle: const badges.BadgeStyle(
                            borderSide: BorderSide(color: Colors.white)),
                        badgeContent: Text(
                          state.totalQuantity.toString(),
                          style: const TextStyle(
                              color: Colors.white, fontSize: 12),
                        ),
                        position: badges.BadgePosition.topEnd(top: 8, end: 16),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context)
                                .pushNamed(CartScreen.routeName);
                          },
                          child: const Icon(
                            Icons.shopping_cart,
                            color: dColorTextAppBar,
                            size: 25,
                          ),
                        ),
                      ),
                    );
                  })
          ],
        ),
        body: _isLoading
            ? const Loader()
            : RefreshIndicator(
                color: Colors.white,
                backgroundColor: Colors.blue,
                onRefresh: () async {
                  context.read<ProductBloc>().add(LoadProducts());
                  context.read<ProductBloc>().add(LoadHotProducts());
                  return Future<void>.delayed(const Duration(seconds: 1));
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const HotProductsWidget(),

                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 10),
                          child: Text(
                            'All Products',
                            style: styleTile,
                          ),
                        ),
                        const AllProductsWidget(),
                        //widget gridview
                      ],
                    ),
                  ),
                ),
              ),
      ),
    );
  }
}
