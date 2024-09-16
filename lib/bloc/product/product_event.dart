abstract class ProductEvent {}

class LoadProducts extends ProductEvent {}
class LoadHotProducts extends ProductEvent {}
class LoadProductById extends ProductEvent {
  final String id;

  LoadProductById(this.id);
}