import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/bloc/product/product_bloc.dart';
import 'package:shoppingcart/bloc/product/product_event.dart';
import 'package:shoppingcart/bloc/product/product_state.dart';
import '../../widget/loading.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key, required this.productId});

  final String productId;

  static String routeName = '/product';

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) => ProductBloc()..add(LoadProductById(productId)),
        child:
            BlocBuilder<ProductBloc, ProductState>(builder: (context, state) {
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
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                    expandedHeight: size.height * 0.51,
                    backgroundColor: Colors.white,
                    floating: true,
                    flexibleSpace: FlexibleSpaceBar(
                        stretchModes: const [StretchMode.zoomBackground],
                        background: Hero(
                          transitionOnUserGestures: true,
                          tag: product.name,
                          child: Image.asset(
                            product.image,
                            fit: BoxFit.fill,
                          ),
                        )),
                    bottom: PreferredSize(
                      preferredSize: Size.fromHeight(100),
                      child: FadeInUp(
                        duration: Duration(milliseconds: 500),
                        child: Transform.translate(offset: const Offset(0, 1),
                          child: Container(
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                            ),
                            child: Center(
                              child: Container(height: 9,width: 45,
                              decoration: BoxDecoration(color: Colors.black12,borderRadius: BorderRadius.circular(20)),),
                            ),
                          ),
                        ),
                      ),
                    ))
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}
