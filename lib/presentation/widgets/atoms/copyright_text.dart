import 'package:flutter/material.dart';

class CopyrightText extends StatelessWidget {
  final String text;

  const CopyrightText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 12,
        fontWeight: FontWeight.w300,
      ),
    );
  }
}