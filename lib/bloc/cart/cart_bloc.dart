import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shoppingcart/model/cart.dart';
import 'cart_event.dart';
import 'cart_state.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartState({})) {
    on<AddToCart>((event, emit) {
      final items = Map<String, CartItem>.from(state.items);

      // print('add : ${event.productId}, so luong: ${event.quantity}');
      if (items.containsKey(event.productId)) {
        final existingItem = items[event.productId]!;
        items[event.productId] = CartItem(
          productId: existingItem.productId,
          image: existingItem.image,
          name: existingItem.name,
          price: existingItem.price,
          quantity: existingItem.quantity + event.quantity,
        );
        // print('update so luong: ${event.productId}, thanh : ${items[event.productId]!.quantity}');
      } else {
        items[event.productId] = CartItem(
          productId: event.productId,
          image: event.image,
          name: event.name,
          price: event.price,
          quantity: event.quantity,
        );
        // print('add thanh cong  ${event.name}');
      }

      emit(CartState(items));
      // print('gio hang gom : ${items}');
    });

    on<IncreaseQuantity>((event, emit) {
      final items = Map<String, CartItem>.from(state.items);
      if (items.containsKey(event.productId)) {
        final item = items[event.productId]!;
        items[event.productId] = CartItem(
          productId: item.productId,
          image: item.image,
          name: item.name,
          price: item.price,
          quantity: item.quantity + event.quantity,
        );
        // print('Tang ${event.productId}, new number: ${items[event.productId]!.quantity}');
      }
      emit(CartState(items));
    });

    on<DecreaseQuantity>((event, emit) {
      final items = Map<String, CartItem>.from(state.items);
      if (items.containsKey(event.productId)) {
        final item = items[event.productId]!;
        final newQuantity = item.quantity - event.quantity;
        if (newQuantity <= 0) {
          items.remove(event.productId);
        } else {
          items[event.productId] = CartItem(
            productId: item.productId,
            image: item.image,
            name: item.name,
            price: item.price,
            quantity: newQuantity,
          );
          // print('giam  ${event.productId}, so luong: ${newQuantity}');
        }
      }
      emit(CartState(items));
    });

    on<RemoveItems>((event, emit) {
      final items = Map<String, CartItem>.from(state.items);
      items.remove(event.productId);
      // print('xoa xong ${event.productId}');
      emit(CartState(items));
    });

    on<UpdateQuantity>((event, emit) {
      final items = Map<String, CartItem>.from(state.items);
      if (items.containsKey(event.productId)) {
        if (event.quantity <= 0) {
          items.remove(event.productId);
        } else {
          items[event.productId] = CartItem(
            productId: items[event.productId]!.productId,
            image: items[event.productId]!.image,
            name: items[event.productId]!.name,
            price: items[event.productId]!.price,
            quantity: event.quantity,
          );
          // print('So luong moi ${event.quantity}');
        }
      }
      emit(CartState(items));
    });

    //clear cart
    on<ClearCart>((event, emit) {
      emit(CartState({}));
    });
  }
}