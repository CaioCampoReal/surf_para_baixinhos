import 'package:flutter/material.dart';

class CustomImage extends StatelessWidget {
  final String imageUrl;
  final double width;
  final double height;
  final BoxFit fit;
  final BorderRadiusGeometry borderRadius;
  final String? semanticLabel; 
  final VoidCallback? onTap; 

  const CustomImage({
    Key? key,
    required this.imageUrl,
    this.width = 320,
    this.height = 240,
    this.fit = BoxFit.cover,
    this.borderRadius = BorderRadius.zero,
    this.semanticLabel, 
    this.onTap, 
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: semanticLabel, 
      image: true, 
      button: onTap != null, 
      onTap: onTap, 
      child: ClipRRect(
        borderRadius: borderRadius,
        child: Image.asset(
          imageUrl,
          width: width,
          height: height,
          fit: fit,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: width,
              height: height,
              color: Colors.grey[300],
              child: const Icon(Icons.error_outline, color: Colors.grey),
            );
          },
        ),
      ),
    );
  }
}