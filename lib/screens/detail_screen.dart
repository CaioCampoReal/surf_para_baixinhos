import 'package:flutter/material.dart';
import '../models/item_model.dart';
import '../components/organisms/product_detail.dart';

class DetailScreen extends StatelessWidget {
  final Item item;

  const DetailScreen({Key? key, required this.item}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Semantics(
          excludeSemantics: true,
          child: Text(item.nome),
        ),
      ),
      body: Semantics(
        label: 'Tela de detalhes do produto ${item.nome}. Preço: R\$ ${item.preco.toStringAsFixed(2)}. ${item.descricao}',
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: ProductDetail(
                imageUrl: item.imageUrl,
                nome: item.nome,
                preco: item.preco,
                descricao: item.descricao,
                heroTag: 'product-image-${item.id}',
              ),
            ),
          ),
        ),
      ),
    );
  }
}