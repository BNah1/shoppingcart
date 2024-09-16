import 'package:flutter/material.dart';
import 'package:shoppingcart/constants/constant.dart';

class TextButtonWidget extends StatelessWidget {
  const TextButtonWidget(
      {super.key, required this.tapButton, required this.text});

  final String text;
  final VoidCallback tapButton;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: InkWell(
        onTap: tapButton,
        child: Container(
          decoration: BoxDecoration(
              color: dColorAppBar, borderRadius: BorderRadius.circular(10)),
          height: 60,
          child: Center(
              child: Text(
            text,
            style: styleTileButton,
          )),
        ),
      ),
    );
  }
}
