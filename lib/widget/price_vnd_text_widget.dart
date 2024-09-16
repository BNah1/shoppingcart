import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;

class PriceVND extends StatelessWidget {
  const PriceVND(
      {super.key,
      required this.price,
      this.size = 15,
      this.weight = FontWeight.normal});

  final int price;
  final int size;
  final FontWeight weight;

  @override
  Widget build(BuildContext context) {
    return Text(intl.NumberFormat.simpleCurrency(locale: 'vi').format(price),
        style: TextStyle(
            color: Colors.orange[700],
            fontSize: size.toDouble(),
            fontWeight: weight));
  }
}
