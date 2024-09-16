import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/bloc/product/product_bloc.dart';
import 'package:shoppingcart/bloc/product/product_event.dart';
import 'package:shoppingcart/bloc/product/product_state.dart';
import 'package:shoppingcart/constants/constant.dart';
import 'package:shoppingcart/widget/bottom_select_product_widget.dart';
import 'package:shoppingcart/widget/loading.dart';
import 'package:shoppingcart/widget/price_vnd_text_widget.dart';

import '../../product/product_screen.dart';

class AllProductsWidget extends StatelessWidget {
  const AllProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc()..add(LoadProducts()),
      child: BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
        if (state is ProductLoading) {
          return const Loader();
        } else if (state is ProductError) {
          return Center(child: Text(state.message));
        } else if (state is ProductLoaded) {
          return GridView.builder(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                childAspectRatio: 3 / 4,
              ),
              itemCount: state.products.length,
              itemBuilder: (BuildContext context, int index) {
                final product = state.products[index];
                return Stack(children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(color: Colors.black12, width: 1),
                    ),
                    child: Column(children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(20)),
                        child: SizedBox(
                          width: 300,
                          child: InkWell(
                            onTap: (){
                              String number = product.id;
                              Navigator.of(context).pushNamed(ProductScreen.routeName, arguments: number);
                            },
                            child: Image.asset(
                              product.image,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(product.name,
                                        style: styleTileItem,
                                        overflow: TextOverflow.ellipsis),
                                    PriceVND(price: product.price)
                                  ]),
                            ),
                            const SizedBox(
                              width: 40,
                            ),
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
                                child: const Icon(Icons.shopping_cart))
                          ],
                        ),
                      )
                    ]),
                  ),
                  product.isHot
                      ? const Positioned(
                          left: 5,
                          top: 10,
                          child: Icon(
                            Icons.local_fire_department,
                            color: Colors.red,
                            size: 30,
                          ),
                        )
                      : const SizedBox.shrink()
                ]);
              });
        }
        return Container();
      }),
    );
  }
}
