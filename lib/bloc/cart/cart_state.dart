import 'package:shoppingcart/model/cart.dart';

class CartState {
  final Map<String, CartItem> items;

  CartState(this.items);

  int get totalPrice {
    return items.values.fold(0, (total, item) => total + item.price * item.quantity);
  }

  int get totalQuantity {
    return items.values.fold(0, (total, item) => total + item.quantity);
  }
}