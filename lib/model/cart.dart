class CartItem {
  final String productId;
  final String image;
  final String name;
  final int price;
  final int quantity;

  CartItem({
    required this.productId,
    required this.image,
    required this.name,
    required this.price,
    required this.quantity,
  });
}