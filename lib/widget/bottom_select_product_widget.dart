import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/bloc/product/product_bloc.dart';
import 'package:shoppingcart/bloc/product/product_event.dart';
import 'package:shoppingcart/bloc/product/product_state.dart';
import 'package:shoppingcart/widget/item_tile_widget.dart';
import 'loading.dart';

class BottomSelectProductWidget extends StatefulWidget {
  const BottomSelectProductWidget({super.key, required this.id});

  final String id;

  @override
  State<BottomSelectProductWidget> createState() => _NumberEditWidgetState();
}

class _NumberEditWidgetState extends State<BottomSelectProductWidget> {
  int numberProduct = 1;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(LoadProductById(widget.id)),
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoading) {
          return const Loader();
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        } else if (state is ProductLoaded) {
          final product =
              state.products.isNotEmpty ? state.products.first : null;

          if (product == null) {
            return const Center(child: Text('Cant'));
          }
          return Container(
            height: 270,
            color: Colors.white,
            child: Column(
              children: [
                CartItemTile(
                    isHome: true,
                    id: product.id,
                    name: product.name,
                    price: product.price,
                    image: product.image,
                    numberProduct: numberProduct,
                    addButton: () {
                      if (numberProduct < 998) {
                        setState(() {
                          numberProduct++;
                        });
                      }
                    },
                    xButton: () {
                      Navigator.pop(context);
                    },
                    minusButton: () {
                      if (numberProduct > 1) {
                        setState(() {
                          numberProduct--;
                        });
                      }
                    },
                    onNumberUpdated: (newNumber) {
                      setState(() {
                        numberProduct = newNumber;
                      });
                    })
              ],
            ),
          );
        }
        return Container();
      }),
    );
  }
}
