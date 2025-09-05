import 'package:flutter/material.dart';
import '../atoms/title_text.dart';
import '../atoms/price_text.dart';

class ProductInfo extends StatelessWidget {
  final String nome;
  final double preco;
  final String descricao;

  const ProductInfo({
    Key? key,
    required this.nome,
    required this.preco,
    required this.descricao,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Informações do produto: $nome. Preço: R\$ ${preco.toStringAsFixed(2)}. Descrição: $descricao',
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Semantics(
              excludeSemantics: true,
              child: TitleText(
                text: nome,
                fontSize: 24,
                fontWeight: FontWeight.bold,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 12),
            Semantics(
              excludeSemantics: true, 
              child: PriceText(
                price: preco,
                fontSize: 20,
                color: Colors.green[700]!,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Semantics(
              excludeSemantics: true, 
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  descricao,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}