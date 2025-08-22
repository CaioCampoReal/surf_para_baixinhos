import 'package:flutter/material.dart';
import '../models/item_model.dart';
import './item_card.dart';
import 'detail_screen.dart';
import '../theme.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Item> _items = [
    Item(
      id: 1,
      nome: 'Pneu de alta performance',
      preco: 299.90,
      imageUrl: 'https://example.com/pneu.jpg',
      descricao: 'Pneu para carros esportivos, alta durabilidade e aderência.',
    ),
    Item(
      id: 2,
      nome: 'Volante esportivo',
      preco: 450.00,
      imageUrl: 'https://example.com/volante.jpg',
      descricao:
          'Volante confortável e com grip perfeito para direção esportiva.',
    ),
    Item(
      id: 3,
      nome: 'Farol LED',
      preco: 350.00,
      imageUrl: 'https://example.com/farol_led.jpg',
      descricao:
          'Farol com tecnologia LED para melhor visibilidade e menor consumo.',
    ),
    Item(
      id: 4,
      nome: 'Banco esportivo',
      preco: 1200.00,
      imageUrl: 'https://example.com/banco_esportivo.jpg',
      descricao:
          'Banco com design ergonômico para maior conforto e suporte lateral.',
    ),
    Item(
      id: 5,
      nome: 'Kit suspensão esportiva',
      preco: 1800.00,
      imageUrl: 'https://example.com/suspensao.jpg',
      descricao:
          'Kit completo para melhorar a estabilidade e resposta do carro.',
    ),
    Item(
      id: 6,
      nome: 'Escape esportivo',
      preco: 950.00,
      imageUrl: 'https://example.com/escape.jpg',
      descricao: 'Escape que melhora o desempenho e o som do motor.',
    ),
    Item(
      id: 7,
      nome: 'Tapetes personalizados',
      preco: 150.00,
      imageUrl: 'https://example.com/tapetes.jpg',
      descricao:
          'Tapetes resistentes e com design exclusivo para o interior do carro.',
    ),
  ];

  final List<String> _carouselImages = [
    'https://example.com/banner1.jpg',
    'https://example.com/banner2.jpg',
    'https://example.com/banner3.jpg',
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loja de Itens para Carros'),
        backgroundColor: AppColors.primaryBlue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título carrossel
            Text(
              'Destaques',
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.burntYellow,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),

            // Carrossel scroll horizontal
            SizedBox(
              height: 180,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _carouselImages.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final url = _carouselImages[index];
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      url,
                      width: 320,
                      height: 180,
                      fit: BoxFit.cover,
                      loadingBuilder: (context, child, progress) {
                        if (progress == null) return child;
                        return const Center(child: CircularProgressIndicator());
                      },
                      errorBuilder: (context, error, stackTrace) => Container(
                        width: 320,
                        height: 180,
                        color: Colors.grey[300],
                        child: const Icon(Icons.broken_image, size: 60),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 24),

            // Título lista
            Text(
              'Itens disponíveis',
              style: theme.textTheme.titleLarge?.copyWith(
                color: AppColors.yellowHighlight,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            // Lista expansível de itens
            Expanded(
              child: GridView.builder(
                itemCount: _items.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  final item = _items[index];
                  return ItemCard(
                    item: item,
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => DetailScreen(item: item),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
