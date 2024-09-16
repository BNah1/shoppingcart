import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/bloc/product/product_event.dart';
import 'package:shoppingcart/bloc/product/product_state.dart';
import 'package:shoppingcart/model/product.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitial()) {
    on<LoadProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        List<Product> products = await fetchProducts();
        emit(ProductLoaded(products));
      } catch (e) {
        emit(ProductError('Failed to load products: ${e.toString()}'));
      }
    });

    on<LoadHotProducts>((event, emit) async {
      emit(ProductLoading());
      try {
        List<Product> products = await fetchProducts();
        List<Product> hotProducts =
        products.where((product) => product.isHot).toList();
        emit(ProductLoaded(hotProducts));
      } catch (e) {
        emit(ProductError('Failed to load hot products: ${e.toString()}'));
      }
    });

    on<LoadProductById>((event, emit) async {
      emit(ProductLoading());
      try {
        List<Product> products = await fetchProducts();
        Product? product = products.firstWhere(
                (product) => product.id == event.id,
            orElse: () => throw Exception('Product not found'));
        emit(ProductLoaded([product]));
      } catch (e) {
        emit(ProductError('Failed to load product: ${e.toString()}'));
      }
    });
  }
}

Future<List<Product>> fetchProducts() async {
  try {
    final String response = await rootBundle.loadString('assets/product.json');
    final List<dynamic> data = json.decode(response);
    return data.map((item) => Product.fromMap(item)).toList();
  } catch (e) {
    return [];
  }
}
