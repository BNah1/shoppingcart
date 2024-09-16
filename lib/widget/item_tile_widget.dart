import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/bloc/cart/cart_bloc.dart';
import 'package:shoppingcart/bloc/cart/cart_event.dart';
import 'package:shoppingcart/constants/constant.dart';
import 'package:shoppingcart/widget/price_vnd_text_widget.dart';
import 'package:shoppingcart/widget/text_button.dart';
import '../screen/product/product_screen.dart';
import 'number_edit_widget.dart';

class CartItemTile extends StatefulWidget {
  const CartItemTile({
    super.key,
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    required this.numberProduct,
    required this.addButton,
    required this.xButton,
    required this.minusButton,
    required this.isHome,
    required this.onNumberUpdated,
  });

  final int numberProduct;
  final String id;
  final String name;
  final int price;
  final String image;
  final VoidCallback addButton;
  final VoidCallback xButton;
  final VoidCallback minusButton;
  final bool isHome;
  final ValueChanged<int> onNumberUpdated;

  @override
  State<CartItemTile> createState() => _CartItemTileState();
}

class _CartItemTileState extends State<CartItemTile> {
  late int numberProduct;

  @override
  @override
  void initState() {
    super.initState();
    if (widget.isHome == true) {
      numberProduct = 1;
    } else {
      numberProduct = widget.numberProduct;
    }
  }

  void _updateNumber(int newNumber) {
    if (widget.isHome == true) {
      setState(() {
        numberProduct = newNumber;
      });
      widget.onNumberUpdated(numberProduct);
    } else {
      setState(() {
        BlocProvider.of<CartBloc>(context)
            .add(UpdateQuantity(productId: widget.id, quantity: newNumber));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey[30],
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: Colors.black12)),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
            child: Container(
              height: 120,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(25)),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                child: Row(
                  children: [
                    SizedBox(
                      height: 90,
                      width: 90,
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(20)),
                          child: SizedBox(
                            height: 200,
                            width: 300,
                            child: InkWell(
                              onTap: (){
                                String number = widget.id;
                                Navigator.of(context).pushNamed(ProductScreen.routeName, arguments: number);
                              },
                              child: Image.asset(
                                widget.image,
                                fit: BoxFit.cover,
                              ),
                            ),
                          )),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: styleTileItem,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 50,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.black, width: 1),
                                  borderRadius: BorderRadius.circular(25)),
                              child: Row(
                                children: [
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: widget.minusButton,
                                      child: const SizedBox(
                                        height: 100,
                                        child: Center(
                                            child: Text(
                                          '-',
                                          style: TextStyle(fontSize: 32),
                                        )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 2,
                                    child: InkWell(
                                      onTap: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) {
                                            return AlertDialog(
                                              content: NumberEditWidget(
                                                initialValue:
                                                    widget.numberProduct,
                                                onSubmit: _updateNumber,
                                              ),
                                            );
                                          },
                                        );
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          border: Border.symmetric(
                                            vertical: BorderSide(
                                                color: Colors.black, width: 1),
                                          ),
                                        ),
                                        child: Center(
                                            child: Text(
                                          widget.numberProduct.toString(),
                                          style: styleTileItem,
                                        )),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    flex: 1,
                                    child: InkWell(
                                      onTap: widget.addButton,
                                      child:
                                          const Center(child: Icon(Icons.add)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                            height: 40,
                            width: 40,
                            child: TextButton(
                              onPressed: widget.xButton,
                              style: TextButton.styleFrom(
                                side: const BorderSide(
                                    color: Colors.black26, width: 1),
                                shape: const RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                              child: const Text('X'),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          PriceVND(
                              price: widget.price * widget.numberProduct,
                              weight: FontWeight.bold)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          widget.isHome
              ? TextButtonWidget(
                  tapButton: () {
                    BlocProvider.of<CartBloc>(context).add(AddToCart(
                        productId: widget.id,
                        image: widget.image,
                        name: widget.name,
                        price: widget.price,
                        quantity: widget.numberProduct));
                    //test thu
                    // print(widget.id);
                    // print('Added ${widget.name} to cart');
                    Navigator.pop(context);
                  },
                  text: 'Add to Cart')
              : const SizedBox.shrink()
        ]),
      ),
    );
  }
}
