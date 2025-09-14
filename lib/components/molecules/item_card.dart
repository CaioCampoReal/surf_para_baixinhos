import 'package:flutter/material.dart';
import '../../models/item_model.dart';
import '../atoms/custom_image.dart';
import '../atoms/title_text.dart';
import '../atoms/price_text.dart';

class ItemCard extends StatefulWidget { 
  final Item item;
  final VoidCallback onTap;

  const ItemCard({
    Key? key,
    required this.item,
    required this.onTap,
  }) : super(key: key);

  @override
  State<ItemCard> createState() => _ItemCardState();
}

class _ItemCardState extends State<ItemCard> with SingleTickerProviderStateMixin {
  late AnimationController _controller; 
  late Animation<double> _scaleAnimation; 
  bool _isPressed = false; 

  @override
  void initState() {
    super.initState();
    
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose(); 
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    setState(() {
      _isPressed = true;
    });
    _controller.forward(); 
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() {
      _isPressed = false;
    });
    _controller.reverse(); 
    widget.onTap(); 
  }

  void _handleTapCancel() {
    setState(() {
      _isPressed = false;
    });
    _controller.reverse(); 
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Produto: ${widget.item.nome}. Preço: R\$ ${widget.item.preco.toStringAsFixed(2)}. Toque duas vezes para ver detalhes.',
      button: true,
      onTap: widget.onTap,
      child: GestureDetector(
        onTapDown: _handleTapDown,    
        onTapUp: _handleTapUp,        
        onTapCancel: _handleTapCancel, 
        child: ScaleTransition(        
          scale: _scaleAnimation,
          child: Card(
            elevation: _isPressed ? 1 : 2, 
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(12),
                      topRight: Radius.circular(12),
                    ),
                    child: Hero(
                      tag: 'product-image-${widget.item.id}',
                      child: CustomImage(
                        imageUrl: widget.item.imageUrl,
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(12),
                          topRight: Radius.circular(12),
                        ),
                        semanticLabel: 'Imagem do produto ${widget.item.nome}',
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleText(
                        text: widget.item.nome,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        textAlign: TextAlign.left,
                      ),
                      const SizedBox(height: 4),
                      PriceText(
                        price: widget.item.preco,
                        fontSize: 14,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}