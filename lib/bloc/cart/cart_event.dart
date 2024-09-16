abstract class CartEvent {}

class AddToCart extends CartEvent {
  final String productId;
  final String image;
  final String name;
  final int price;
  final int quantity;

  AddToCart({
    required this.productId,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  });
}

class IncreaseQuantity extends CartEvent {
  final String productId;
  final int quantity;

  IncreaseQuantity(this.productId, [this.quantity = 1]);
}

class UpdateQuantity extends CartEvent {
  final String productId;
  final int quantity;

  UpdateQuantity({
    required this.productId,
    required this.quantity,
  });
}
class ClearCart extends CartEvent {}

class DecreaseQuantity extends CartEvent {
  final String productId;
  final int quantity;

  DecreaseQuantity(this.productId, [this.quantity = 1]);
}

class RemoveItems extends CartEvent {
  final String productId;

  RemoveItems(this.productId);
}