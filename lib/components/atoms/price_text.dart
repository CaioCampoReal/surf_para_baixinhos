import 'package:flutter/material.dart';

class PriceText extends StatelessWidget {
  final double price;
  final String prefix;
  final double fontSize;
  final Color color;
  final FontWeight fontWeight;

  const PriceText({
    Key? key,
    required this.price,
    this.prefix = 'R\$',
    this.fontSize = 20,
    this.color = Colors.green,
    this.fontWeight = FontWeight.bold,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      '$prefix ${price.toStringAsFixed(2)}',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: fontWeight,
      ),
    );
  }
}