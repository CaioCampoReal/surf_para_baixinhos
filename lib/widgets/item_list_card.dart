import 'package:flutter/material.dart';
import 'package:meu_projeto_integrador/models/item_model.dart';

class ItemListCard extends StatelessWidget {
  final Item item;
  final VoidCallback onTap;

  const ItemListCard({
    super.key,
    required this.item,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4, // Sombra sutil para destacar o card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell( // Efeito de feedback visual ao tocar
        onTap: onTap,
        borderRadius: BorderRadius.circular(10), // Aplica o borderRadius ao InkWell
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start, // Alinha itens ao topo da linha
            children: [
              // Imagem do item
              ClipRRect( // Recorta a imagem com bordas arredondadas
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  item.imageUrl,
                  width: 90,
                  height: 90,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    // Placeholder para caso a imagem não carregue
                    return Container(
                      width: 90,
                      height: 90,
                      color: Colors.grey[300],
                      child: Icon(Icons.image_not_supported, color: Colors.grey[600]),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16), // Espaço entre imagem e texto

              // Coluna com Nome, Preço e Descrição
              Expanded( // Permite que a coluna de texto ocupe o espaço restante
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.nome,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1, // Limita o título a uma linha
                      overflow: TextOverflow.ellipsis, // Adiciona "..." se o texto for muito longo
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'R\$ ${item.preco.toStringAsFixed(2)}', // Formata o preço
                      style: const TextStyle(
                        fontSize: 16,
                        color: Colors.green,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      item.descricao,
                      style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      maxLines: 2, // Limita a descrição a duas linhas
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 10), // Espaço antes do ícone final

              // Ícone de navegação
              const Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.arrow_forward_ios, color: Colors.grey, size: 20),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
