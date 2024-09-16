import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/bloc/product/product_bloc.dart';
import 'package:shoppingcart/bloc/product/product_event.dart';
import 'package:shoppingcart/bloc/product/product_state.dart';
import 'package:shoppingcart/constants/constant.dart';
import 'package:shoppingcart/screen/product/product_screen.dart';
import 'package:shoppingcart/widget/bottom_select_product_widget.dart';
import 'package:shoppingcart/widget/loading.dart';
import 'package:shoppingcart/widget/price_vnd_text_widget.dart';

class HotProductsWidget extends StatelessWidget {
  const HotProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(LoadHotProducts()),
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoading) {
          return const Loader();
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        } else if (state is ProductLoaded) {
          return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(children: [
                    Text(
                      'HOT Product',
                      style: styleTile,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Icon(
                      Icons.local_fire_department,
                      color: Colors.red,
                    )
                  ]),
                ),
                SizedBox(
                  height: 220,
                  child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(
                          width: 10,
                        );
                      },
                      itemCount: state.products.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        final product = state.products[index];
                        return Stack(children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              border:
                                  Border.all(color: Colors.black12, width: 1),
                            ),
                            width: MediaQuery.of(context).size.width / 2.5 - 10,
                            child: Column(children: [
                              ClipRRect(
                                borderRadius: const BorderRadius.vertical(
                                    top: Radius.circular(20)),
                                child: InkWell(
                                  onTap: (){
                                    String number = product.id;
                                    Navigator.of(context).pushNamed(ProductScreen.routeName, arguments: number);
                                  },
                                  child: SizedBox(
                                    height: 150,
                                    width: 150,
                                    child: Image.asset(
                                      product.image,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            product.name,
                                            style: const TextStyle(
                                                fontWeight: FontWeight.bold),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          PriceVND(price: product.price)
                                        ],
                                      ),
                                    ),
                                    const SizedBox(width: 12),
                                    InkWell(
                                        onTap: () {
                                          showModalBottomSheet(
                                              context: context,
                                              isScrollControlled: true,
                                              builder: (BuildContext context) {
                                                return BottomSelectProductWidget(
                                                    id: product.id);
                                              });
                                        },
                                        child: const Icon(Icons.shopping_cart)),
                                  ],
                                ),
                              )
                            ]),
                          ),
                          const Positioned(
                            left: 5,
                            top: 10,
                            child: Icon(
                              Icons.local_fire_department,
                              color: Colors.red,
                              size: 30,
                            ),
                          ),
                        ]);
                      }),
                ),
              ]);
        }
        return Container();
      }),
    );
  }
}
