import 'package:flutter/material.dart';
import '../../../../domain/entities/item.dart';
import '../molecules/item_card.dart';

class ProductGrid extends StatelessWidget {
  final List<Item> items;
  final Function(Item) onItemTap;
  final Function(Item)? onAddToCart;

  const ProductGrid({
    Key? key,
    required this.items,
    required this.onItemTap,
    this.onAddToCart,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: items.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.75,
      ),
      itemBuilder: (context, index) {
        final item = items[index];
        return ItemCard(
          item: item,
          onTap: () => onItemTap(item),
          onAddToCart: onAddToCart,
        );
      },
    );
  }
}
