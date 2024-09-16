import 'dart:convert';

class Product {
  String id;
  String name;
  String image;
  int price;
  bool isHot;
  String detail;
  int quantityStore;

  Product(
      {required this.id,
      required this.name,
      required this.image,
      required this.price,
      required this.isHot,
      required this.detail,
      required this.quantityStore});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'image': image,
      'price': price.toString(),
      'isHot': isHot.toString(),
      'detail': detail,
      'quantityStore': quantityStore.toString(),
    };
  }

  factory Product.fromMap(Map<String, dynamic> map) {
    return Product(
      id: map['id'] as String,
      name: map['name'] as String,
      image: map['image'] as String,
      price: int.parse(map['price'] as String),
      isHot: map['isHot'].toLowerCase() == 'true',
      detail: map['detail'] as String,
      quantityStore: int.parse(map['quantityStore'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory Product.fromJson(String source) =>
      Product.fromMap(json.decode(source) as Map<String, dynamic>);
}
