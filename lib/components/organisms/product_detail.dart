import 'package:flutter/material.dart';
import '../atoms/custom_image.dart';
import '../molecules/product_info.dart';

class ProductDetail extends StatelessWidget {
  final String imageUrl;
  final String nome;
  final double preco;
  final String descricao;

  const ProductDetail({
    Key? key,
    required this.imageUrl,
    required this.nome,
    required this.preco,
    required this.descricao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CustomImage(
            imageUrl: imageUrl,
            width: 320,
            height: 240,
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        const SizedBox(height: 20),
        ProductInfo(
          nome: nome,
          preco: preco,
          descricao: descricao,
        ),
      ],
    );
  }
}