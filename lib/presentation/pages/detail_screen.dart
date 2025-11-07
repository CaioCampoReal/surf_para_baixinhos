import 'package:flutter/material.dart';
import '../../domain/entities/item.dart';
import '../widgets/organisms/app_bar_custom.dart';
import '../widgets/organisms/product_detail.dart';
import '../widgets/organisms/footer.dart';
import '../theme/app_theme.dart';

class DetailScreen extends StatelessWidget {
  final Item item;

  const DetailScreen({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom( 
        title: item.nome,
        backgroundColor: AppColors.primaryBlue, 
        foregroundColor: Colors.white,
        semanticLabel: 'Cabeçalho de detalhes do produto ${item.nome}',
      ),
      body: SingleChildScrollView( 
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Center(
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
            
            const SizedBox(height: 220),
            
            const Footer(),
          ],
        ),
      ),
    );
  }
}