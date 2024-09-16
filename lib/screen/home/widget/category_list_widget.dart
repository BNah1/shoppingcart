import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/bloc/category/category_bloc.dart';
import 'package:shoppingcart/bloc/category/category_event.dart';

class CategoryListWidget extends StatelessWidget {
  const CategoryListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CategoryBloc()..add(LoadCategory()),
        child: Container());
  }
}
