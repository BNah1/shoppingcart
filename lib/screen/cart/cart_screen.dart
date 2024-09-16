import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:shoppingcart/bloc/cart/cart_bloc.dart';
import 'package:shoppingcart/bloc/cart/cart_event.dart';
import 'package:shoppingcart/bloc/cart/cart_state.dart';
import 'package:shoppingcart/constants/constant.dart';
import 'package:shoppingcart/screen/home/home_screen.dart';
import 'package:shoppingcart/widget/item_tile_widget.dart';
import 'package:shoppingcart/widget/price_vnd_text_widget.dart';
import 'package:shoppingcart/widget/text_button.dart';

class CartScreen extends StatefulWidget {
  static String routeName = '/cart';

  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: dColorAppBar,
        centerTitle: true,
        title: BlocBuilder<CartBloc, CartState>(
          builder: (context, state) {
            return Text(
              'Cart (${state.totalQuantity})',
              style: styleTileAppbar,
            );
          },
        ),
      ),
      body: BlocBuilder<CartBloc, CartState>(
        builder: (context, state) {
          if (state.items.isEmpty) {
            return Center(
                child: Text(
              'Empty Cart',
              style: styleTile,
            ));
          }
          return ListView.builder(
              itemCount: state.items.length,
              itemBuilder: (context, index) {
                final productId = state.items.keys.elementAt(index);
                final item = state.items[productId];
                return Slidable(
                  key: ValueKey(item?.productId),
                  startActionPane: ActionPane(
                    extentRatio: 0.3,
                    motion: const ScrollMotion(),
                    dismissible: DismissiblePane(onDismissed: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(RemoveItems(item!.productId));
                    }),
                    children: [
                      SlidableAction(
                        onPressed: (context){
                          BlocProvider.of<CartBloc>(context)
                              .add(RemoveItems(item!.productId));
                        },
                        backgroundColor: const Color(0xFFFE4A49),
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: CartItemTile(
                    onNumberUpdated: (newNumber) {},
                    isHome: false,
                    id: item!.productId,
                    name: item.name,
                    price: item.price,
                    image: item.image,
                    numberProduct: item.quantity,
                    addButton: () {
                      if (item.quantity < 998) {
                        BlocProvider.of<CartBloc>(context)
                            .add(IncreaseQuantity(item.productId));
                      }
                    },
                    xButton: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(RemoveItems(item.productId));
                    },
                    minusButton: () {
                      BlocProvider.of<CartBloc>(context)
                          .add(DecreaseQuantity(item.productId));
                    },
                  ),
                );
              });
        },
      ),
      bottomNavigationBar:
          BlocBuilder<CartBloc, CartState>(builder: (context, state) {
        if (state.items.isEmpty) {
          return const SizedBox.shrink();
        }
        return Container(
          color: Colors.grey[200],
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Total Price',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      BlocBuilder<CartBloc, CartState>(
                        builder: (context, state) {
                          final totalPrice = state.totalPrice;
                          return PriceVND(
                            price: totalPrice,
                            weight: FontWeight.bold,
                            size: 20,
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: TextButtonWidget(
                      tapButton: () {
                        // mua thanh cong
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                content: SizedBox(
                              height: 100,
                              child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text(
                                      'Order Successfully !',
                                      style: TextStyle(
                                          fontSize: 25,
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const HomeScreen()),
                                            (Route<dynamic> route) => false);
                                      },
                                      style: TextButton.styleFrom(
                                        backgroundColor: Colors.orange,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                      ),
                                      child: const SizedBox(
                                        width: 200,
                                        child: Text(
                                          'Back to Home!',
                                          style: TextStyle(
                                              fontSize: 22,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    )
                                  ]),
                            ));
                          },
                        );
                        // clear after bought
                        BlocProvider.of<CartBloc>(context).add(ClearCart());
                      },
                      text: 'Buy Now')),
              const SizedBox(height: 20),
            ],
          ),
        );
      }),
    );
  }
}
