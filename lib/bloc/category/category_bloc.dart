import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/bloc/category/category_event.dart';
import 'package:shoppingcart/bloc/category/category_state.dart';
import 'package:shoppingcart/model/category.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryBloc() : super(CategoryInitial()) {

    on<LoadCategory>((event , emit) async {
      emit(CategoryLoading());
      try{
        List<Category> categories =  await fetchCategory();
        emit(CategoryLoaded(categories));
      }catch(e){
        emit(CategoryError('Failed to load products: ${e.toString()}'));
      }
    });
  }
}

Future<List<Category>> fetchCategory() async {
  try {
    final String response =
    await rootBundle.loadString('assets/category.json');
    final List<dynamic> data = jsonDecode(response);
    return data.map((item) => Category.fromMap(item)).toList();
  } catch (e) {
    return [];
  }
}