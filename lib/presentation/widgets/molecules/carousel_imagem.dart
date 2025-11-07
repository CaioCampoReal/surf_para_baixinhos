import 'package:flutter/material.dart';

class CarouselImage extends StatelessWidget {
  final String imageUrl;
  final double height;
  final double width;

  const CarouselImage({
    Key? key,
    required this.imageUrl,
    required this.height,
    this.width = double.infinity,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Image.asset(
          imageUrl,
          width: width,
          height: height,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}