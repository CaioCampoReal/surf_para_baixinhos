import 'package:flutter/material.dart';
import 'package:meu_projeto_integrador/mocks/item_list.dart';
import 'package:meu_projeto_integrador/models/item_model.dart';
import '../components/organisms/app_bar_custom.dart';
import '../components/organisms/image_carousel.dart';
import '../components/organisms/product_grid.dart';
import '../components/molecules/section_title.dart';
import '../theme.dart';
import 'detail_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _items = itemsMock;

  final List<String> _carouselImages = [
    'assets/carrossel.png',
    'assets/carrossel2.png',
    'assets/carrossel3.png',
  ];

  void _navigateToDetail(Item item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailScreen(item: item),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarCustom(
        title: 'Surf Para Baixinhos',
        backgroundColor: AppColors.primaryBlue,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ImageCarousel(images: _carouselImages),
            
            const SizedBox(height: 24),
            
            SectionTitle(
              title: 'Itens disponíveis',
              color: AppColors.primaryBlue,
            ),
            
            const SizedBox(height: 12),
            
            ProductGrid(
              items: _items,
              onItemTap: _navigateToDetail,
            ),
            
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}